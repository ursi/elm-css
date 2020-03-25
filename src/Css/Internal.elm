module Css.Internal exposing
    ( Declaration(..)
    , joinMap
    , seed
    , tmpClass
    , toStrings
    )

import Dict exposing (Dict)


type Declaration
    = Single (String -> String) String String
    | Batch (List Declaration)
    | Inline (List Declaration)


type alias StylePairs =
    { node : Dict String (List ( String, String ))
    , inline : List ( String, String )
    }


joinMap : (a -> String) -> String -> List a -> String
joinMap f sep list =
    case list of
        [ only ] ->
            f only

        first :: rest ->
            f first ++ sep ++ joinMap f sep rest

        [] ->
            ""


seed : Int
seed =
    0


toStrings :
    List Declaration
    ->
        Maybe
            { node : Maybe String
            , inline : Maybe String
            }
toStrings declarations =
    if List.isEmpty declarations then
        Nothing

    else
        let
            { node, inline } =
                toStylePairs declarations
        in
        Just
            { node =
                node
                    |> Dict.toList
                    |> joinMap
                        (\( selector, pairs ) ->
                            selector
                                ++ " {\n"
                                ++ (pairs
                                        |> joinMap
                                            (\( property, value ) ->
                                                "\t" ++ property ++ ": " ++ value ++ ";"
                                            )
                                            "\n"
                                   )
                                ++ "\n}"
                        )
                        "\n"
                    |> (\str ->
                            if String.isEmpty str then
                                Nothing

                            else
                                Just str
                       )
            , inline =
                inline
                    |> joinMap
                        -- this is how the browser styles it
                        (\( property, value ) ->
                            property ++ ": " ++ value ++ ";"
                        )
                        " "
                    |> (\str ->
                            if String.isEmpty str then
                                Nothing

                            else
                                Just str
                       )
            }


tmpClass : String
tmpClass =
    "!@#$%^&*()"


toStylePairs : List Declaration -> StylePairs
toStylePairs =
    toStylePairsFrom <| StylePairs Dict.empty []


toStylePairsFrom :
    StylePairs
    -> List Declaration
    -> StylePairs
toStylePairsFrom ({ node, inline } as stylePairs) declarations =
    case declarations of
        first :: rest ->
            case first of
                Single classToSelector property value ->
                    let
                        selector =
                            classToSelector tmpClass
                    in
                    toStylePairsFrom
                        { node =
                            node
                                |> Dict.insert selector
                                    (case Dict.get selector node of
                                        Just pairs ->
                                            ( property, value ) :: pairs

                                        Nothing ->
                                            [ ( property, value ) ]
                                    )
                        , inline = inline
                        }
                        rest

                Batch declarations_ ->
                    toStylePairsFrom
                        { node = node
                        , inline = inline
                        }
                        (declarations_ ++ rest)

                Inline declarations_ ->
                    toStylePairsFrom
                        { node = node
                        , inline = toPairs declarations_ ++ inline
                        }
                        rest

        [] ->
            stylePairs


toPairs : List Declaration -> List ( String, String )
toPairs =
    List.foldr
        (\declaration pairs ->
            case declaration of
                Single _ property value ->
                    ( property, value ) :: pairs

                Batch declarations ->
                    toPairs declarations ++ pairs

                Inline declarations ->
                    toPairs declarations ++ pairs
        )
        []
