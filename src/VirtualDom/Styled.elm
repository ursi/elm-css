module VirtualDom.Styled exposing (..)

import Css.Global as G exposing (Statement)
import Css.Internal as I exposing (Declaration)
import Dict exposing (Dict)
import Html.Attributes as A
import Murmur3
import VirtualDom as V



-- TODO maybe separate some of this into it's own virtual dom library like rtfeldman/elm-css'
-- or maybe move it to Css.Internal


type Node msg
    = Node String (List (Attribute msg)) (List (Node msg))
    | NodeNS String String (List (Attribute msg)) (List (Node msg))
    | KeyedNode String (List (Attribute msg)) (List ( String, Node msg ))
    | KeyedNodeNS String String (List (Attribute msg)) (List ( String, Node msg ))
    | StyledNode String (List Declaration) (List (Attribute msg)) (List (Node msg))
    | StyledNodeNS String String (List Declaration) (List (Attribute msg)) (List (Node msg))
    | StyledKeyedNode String (List Declaration) (List (Attribute msg)) (List ( String, Node msg ))
    | StyledKeyedNodeNS String String (List Declaration) (List (Attribute msg)) (List ( String, Node msg ))
    | VNode (V.Node msg)


withStyles : List Statement -> List (Node msg) -> List (V.Node msg)
withStyles statments nodes =
    let
        ( nodes_, styleDict ) =
            List.foldr
                folder
                ( [], Dict.empty )
                nodes
    in
    (G.toStyleNode statments <| toStyleNodes styleDict)
        :: nodes_


toNode : Node msg -> V.Node msg
toNode node_ =
    case node_ of
        Node tag attributes children ->
            toStyledNode Nothing Nothing tag attributes children

        NodeNS ns tag attributes children ->
            toStyledNode Nothing (Just ns) tag attributes children

        KeyedNode tag attributes children ->
            toStyledKeyedNode Nothing Nothing tag attributes children

        KeyedNodeNS ns tag attributes children ->
            toStyledKeyedNode Nothing (Just ns) tag attributes children

        StyledNode tag declarations attributes children ->
            toStyledNode
                (getHashAndString declarations)
                Nothing
                tag
                attributes
                children

        StyledNodeNS ns tag declarations attributes children ->
            toStyledNode
                (getHashAndString declarations)
                (Just ns)
                tag
                attributes
                children

        StyledKeyedNode tag declarations attributes children ->
            toStyledKeyedNode
                (getHashAndString declarations)
                Nothing
                tag
                attributes
                children

        StyledKeyedNodeNS ns tag declarations attributes children ->
            toStyledKeyedNode
                (getHashAndString declarations)
                (Just ns)
                tag
                attributes
                children

        VNode vNode ->
            vNode


fromNode : V.Node msg -> Node msg
fromNode =
    VNode


toStyledNode :
    Maybe ( String, String )
    -> Maybe String
    -> String
    -> List (Attribute msg)
    -> List (Node msg)
    -> V.Node msg
toStyledNode maybeHashAndString maybeNS tag attributes children =
    let
        ( dict, newAttributes ) =
            toStyledNodeHelper maybeHashAndString attributes

        ( children_, styleDict ) =
            List.foldr
                folder
                ( [], dict )
                children
    in
    (case maybeNS of
        Just ns ->
            V.nodeNS ns

        Nothing ->
            V.node
    )
        tag
        newAttributes
        (addStyleNodes styleDict children_)


toStyledKeyedNode :
    Maybe ( String, String )
    -> Maybe String
    -> String
    -> List (Attribute msg)
    -> List ( String, Node msg )
    -> V.Node msg
toStyledKeyedNode maybeHashAndString maybeNS tag attributes children =
    let
        ( dict, newAttributes ) =
            toStyledNodeHelper maybeHashAndString attributes

        ( children_, styleDict ) =
            List.foldr
                folder
                ( [], dict )
                (List.map Tuple.second children)
    in
    (case maybeNS of
        Just ns ->
            V.keyedNodeNS ns

        Nothing ->
            V.keyedNode
    )
        tag
        newAttributes
        (addKeyedStyleNodes
            styleDict
            (copyIds children children_)
        )


copyIds : List ( String, Node msg ) -> List (V.Node msg) -> List ( String, V.Node msg )
copyIds keyed unkeyed =
    List.map2
        (\( id, _ ) child -> ( id, child ))
        keyed
        unkeyed


toStyledNodeHelper :
    Maybe ( String, String )
    -> List (Attribute msg)
    -> ( Dict String String, List (Attribute msg) )
toStyledNodeHelper maybeHashAndString attributes =
    case maybeHashAndString of
        Just ( hash, decsStr ) ->
            ( Dict.singleton hash decsStr
            , addClass hash attributes
            )

        Nothing ->
            ( Dict.empty
            , attributes
            )


addStyleNodes : Dict String String -> List (V.Node msg) -> List (V.Node msg)
addStyleNodes styleDict nodes =
    let
        styleNodes =
            toStyleNodes styleDict
    in
    if List.isEmpty styleNodes then
        nodes

    else
        V.keyedNode "style" [] styleNodes :: nodes



-- TODO: don't use an arbitrary string, maybe use a hash


addKeyedStyleNodes : Dict String String -> List ( String, V.Node msg ) -> List ( String, V.Node msg )
addKeyedStyleNodes styleDict nodes =
    let
        styleNodes =
            toStyleNodes styleDict
    in
    if List.isEmpty styleNodes then
        nodes

    else
        ( "elm-css node", V.keyedNode "style" [] styleNodes ) :: nodes


addClass : String -> List (Attribute msg) -> List (Attribute msg)
addClass =
    (::) << A.class << (++) "_"


folder :
    Node msg
    -> ( List (V.Node msg), Dict String String )
    -> ( List (V.Node msg), Dict String String )
folder node_ ( children, styleDict ) =
    let
        ( newNode, newStyleDict ) =
            folderHelper styleDict node_
    in
    ( newNode :: children, newStyleDict )


folderHelper :
    Dict String String
    -> Node msg
    -> ( V.Node msg, Dict String String )
folderHelper styleDict node_ =
    case node_ of
        Node tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        children
            in
            ( V.node tag attributes children_, newStyleDict )

        NodeNS ns tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        children
            in
            ( V.nodeNS ns tag attributes children_, newStyleDict )

        KeyedNode tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        (List.map Tuple.second children)
            in
            ( V.keyedNode tag
                attributes
                (copyIds children children_)
            , newStyleDict
            )

        KeyedNodeNS ns tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        (List.map Tuple.second children)
            in
            ( V.keyedNodeNS
                ns
                tag
                attributes
                (copyIds children children_)
            , newStyleDict
            )

        StyledNode tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        children
                        styleDict
            in
            ( V.node tag newAttributes children_, newStyleDict )

        StyledNodeNS ns tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        children
                        styleDict
            in
            ( V.nodeNS ns tag newAttributes children_, newStyleDict )

        StyledKeyedNode tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        (List.map Tuple.second children)
                        styleDict
            in
            ( V.keyedNode tag
                attributes
                (copyIds children children_)
            , newStyleDict
            )

        StyledKeyedNodeNS ns tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        (List.map Tuple.second children)
                        styleDict
            in
            ( V.keyedNodeNS
                ns
                tag
                attributes
                (copyIds children children_)
            , newStyleDict
            )

        VNode vNode ->
            ( vNode, styleDict )


folderHelperHelper :
    Maybe ( String, String )
    -> List (Attribute msg)
    -> List (Node msg)
    -> Dict String String
    -> ( List (Attribute msg), ( List (V.Node msg), Dict String String ) )
folderHelperHelper maybeHashAndString attributes nodes styleDict =
    case maybeHashAndString of
        Just ( hash, decsStr ) ->
            ( addClass hash attributes
            , List.foldr
                folder
                ( [], Dict.insert hash decsStr styleDict )
                nodes
            )

        Nothing ->
            ( attributes
            , List.foldr
                folder
                ( [], styleDict )
                nodes
            )


toStyleNodes : Dict String String -> List ( String, V.Node msg )
toStyleNodes =
    Dict.toList
        >> List.map
            (\( hash, ruleTemplate ) ->
                ( hash
                , V.node "style"
                    []
                    [ V.text <|
                        String.replace
                            I.tmpClass
                            ("._" ++ hash)
                            ruleTemplate
                    ]
                )
            )


getHashAndString : List Declaration -> Maybe ( String, String )
getHashAndString declarations =
    let
        maybeDecStr =
            I.toString declarations
    in
    Maybe.map
        (\decsStr ->
            ( String.fromInt <|
                Murmur3.hashString I.seed decsStr
            , decsStr
            )
        )
        maybeDecStr


type alias Html msg =
    Node msg


type alias Attribute msg =
    V.Attribute msg


text : String -> Html msg
text =
    VNode << V.text


node : String -> List (Attribute msg) -> List (Node msg) -> Node msg
node =
    Node


nodeS : String -> List Declaration -> List (Attribute msg) -> List (Node msg) -> Node msg
nodeS =
    StyledNode


nodeNS : String -> String -> List (Attribute msg) -> List (Node msg) -> Node msg
nodeNS =
    NodeNS


nodeNSS : String -> String -> List Declaration -> List (Attribute msg) -> List (Node msg) -> Node msg
nodeNSS =
    StyledNodeNS


map : (a -> msg) -> Node a -> Node msg
map toMsg node_ =
    case node_ of
        Node tag attributes children ->
            Node
                tag
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map (map toMsg) children)

        NodeNS ns tag attributes children ->
            NodeNS
                ns
                tag
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map (map toMsg) children)

        KeyedNode tag attributes children ->
            KeyedNode
                tag
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map
                    (\( id, child ) -> ( id, map toMsg child ))
                    children
                )

        KeyedNodeNS ns tag attributes children ->
            KeyedNodeNS
                ns
                tag
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map
                    (\( id, child ) -> ( id, map toMsg child ))
                    children
                )

        StyledNode tag declarations attributes children ->
            StyledNode
                tag
                declarations
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map (map toMsg) children)

        StyledNodeNS ns tag declarations attributes children ->
            StyledNodeNS
                ns
                tag
                declarations
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map (map toMsg) children)

        StyledKeyedNode tag declarations attributes children ->
            StyledKeyedNode
                tag
                declarations
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map
                    (\( id, child ) -> ( id, map toMsg child ))
                    children
                )

        StyledKeyedNodeNS ns tag declarations attributes children ->
            StyledKeyedNodeNS
                ns
                tag
                declarations
                (List.map (V.mapAttribute toMsg) attributes)
                (List.map
                    (\( id, child ) -> ( id, map toMsg child ))
                    children
                )

        VNode vNode ->
            VNode <| V.map toMsg vNode
