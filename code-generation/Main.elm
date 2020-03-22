module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    -- view
    code


type alias Property =
    ( String
    , { join : Bool
      , list : Maybe JoinType
      }
    )


type JoinType
    = Space
    | Comma


view : Html ()
view =
    table []
        [ thead []
            [ tr []
                [ td [] [ text "Property" ]
                , td [] [ text "Join" ]
                , td [] [ text "List" ]
                ]
            ]
        , tbody [] <|
            List.map toTr <|
                sort properties
        ]


toTr : Property -> Html ()
toTr ( property, propertyProperties ) =
    tr []
        [ td [] [ text property ]
        , td []
            [ input
                [ type_ "checkbox"
                , disabled True
                , checked propertyProperties.join
                ]
                []
            ]
        , td []
            [ input
                [ type_ "checkbox"
                , disabled True
                , checked <| isList propertyProperties.list
                ]
                []
            ]
        ]


isList : Maybe JoinType -> Bool
isList =
    Maybe.map (\_ -> True)
        >> Maybe.withDefault False


code : Html ()
code =
    div [] <| List.map generateCode <| sort properties


generateCode : Property -> Html ()
generateCode ( property, propertyProperties ) =
    let
        join =
            propertyProperties.join

        list =
            propertyProperties.list
    in
    div []
        [ pre []
            [ ""
                |> (++)
                >> (|>)
                    (case list of
                        Just Space ->
                            """
$ : List String -> Declaration
$ = I.Single identity "#" << String.join " "
"""

                        Just Comma ->
                            """
$ : List String -> Declaration
$ = I.Single identity "#" << String.join ", "
"""

                        Nothing ->
                            """
$ : String -> Declaration
$ = I.Single identity "#"
"""
                    )
                |> (++)
                >> (|>)
                    (if join then
                        case list of
                            Just Space ->
                                """
$J : List (List String) -> Declaration
$J = I.Single identity "#" << String.join " " << List.map (String.join " ")
"""

                            Just Comma ->
                                """
$J : List (List String) -> Declaration
$J = I.Single identity "#" << String.join ", " << List.map (String.join " ")
"""

                            Nothing ->
                                """
$J : List String -> Declaration
$J = I.Single identity "#" << String.join " "
"""

                     else
                        ""
                    )
                |> String.replace "$" (camelCase property)
                |> String.replace "#" property
                |> text
            ]
        ]


somethingFirst func str =
    case String.uncons str of
        Just ( first, rest ) ->
            first
                |> String.fromChar
                |> func
                |> (++)
                >> (|>) rest

        Nothing ->
            ""


camelCase : String -> String
camelCase =
    String.split "-"
        >> List.map (somethingFirst String.toUpper)
        >> String.join ""
        >> somethingFirst String.toLower


sort : List Property -> List Property
sort =
    List.sortWith
        (\( property1, pps1 ) ( property2, pps2 ) ->
            let
                firstSort =
                    boolSort True
                        (isList pps1.list)
                        (isList pps2.list)
            in
            if firstSort == EQ then
                let
                    secondSort =
                        boolSort True pps1.join pps2.join
                in
                if secondSort == EQ then
                    if property1 < property2 then
                        LT

                    else
                        GT

                else
                    secondSort

            else
                firstSort
        )


boolSort : Bool -> Bool -> Bool -> Order
boolSort first b1 b2 =
    case ( b1, b2 ) of
        ( True, False ) ->
            if first then
                LT

            else
                GT

        ( False, True ) ->
            if first then
                GT

            else
                LT

        _ ->
            EQ


properties =
    [ ( "align-content"
      , { join = True
        , list = Nothing
        }
      )
    , ( "align-items"
      , { join = True
        , list = Nothing
        }
      )
    , ( "align-self"
      , { join = True
        , list = Nothing
        }
      )
    , ( "alignment-baseline"
      , { join = False
        , list = Nothing
        }
      )
    , ( "all"
      , { join = False
        , list = Nothing
        }
      )
    , ( "animation"
      , { join = True
        , list = Just Comma
        }
      )
    , ( "animation-delay"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-direction"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-duration"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-fill-mode"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-iteration-count"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-name"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-play-state"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "animation-timing-function"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "appearance"
      , { join = False
        , list = Nothing
        }
      )
    , ( "azimuth"
      , { join = True
        , list = Nothing
        }
      )
    , ( "backface-visibility"
      , { join = False
        , list = Nothing
        }
      )
    , ( "background"
      , { join = True
        , list = Just Comma
        }
      )
    , ( "background-attachment"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "background-blend-mode"
      , { join = False
        , list = Nothing
        }
      )
    , ( "background-clip"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "background-color"
      , { join = False
        , list = Nothing
        }
      )
    , ( "background-image"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "background-origin"
      , { join = False
        , list = Just Comma
        }
      )
    , ( "background-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "background-repeat"
      , { join = True
        , list = Just Comma
        }
      )
    , ( "background-size"
      , { join = True
        , list = Just Comma
        }
      )
    , ( "baseline-shift"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-overflow"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-size"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-step"
      , { join = True
        , list = Nothing
        }
      )
    , ( "block-step-align"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-step-insert"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-step-round"
      , { join = False
        , list = Nothing
        }
      )
    , ( "block-step-size"
      , { join = False
        , list = Nothing
        }
      )
    , ( "bookmark-label"
      , { join = False
        , list = Just Space
        }
      )
    , ( "bookmark-level"
      , { join = False
        , list = Nothing
        }
      )
    , ( "bookmark-state"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block-end-color"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-end-style"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-end-width"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block-start-color"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-start-style"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-start-width"
      , { join = False
        , list = Nothing
        }
      )
    , ( "border-block-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-block-width"
      , { join = True
        , list = Nothing
        }
      )

    -- here
    , ( "border-bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-bottom-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-bottom-left-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-bottom-right-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-bottom-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-bottom-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-boundary"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-collapse"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-end-end-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-end-start-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image-outset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image-repeat"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image-slice"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image-source"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-image-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-end-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-end-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-end-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-start-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-start-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-start-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-inline-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-left-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-left-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-left-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-right-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-right-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-right-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-spacing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-start-end-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-start-start-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top-left-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top-right-radius"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-top-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "border-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "box-decoration-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "box-shadow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "box-sizing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "box-snap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "break-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "break-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "break-inside"
      , { join = True
        , list = Nothing
        }
      )
    , ( "caption-side"
      , { join = True
        , list = Nothing
        }
      )
    , ( "caret"
      , { join = True
        , list = Nothing
        }
      )
    , ( "caret-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "caret-shape"
      , { join = True
        , list = Nothing
        }
      )
    , ( "clear"
      , { join = True
        , list = Nothing
        }
      )
    , ( "clip"
      , { join = True
        , list = Nothing
        }
      )
    , ( "clip-path"
      , { join = True
        , list = Nothing
        }
      )
    , ( "clip-rule"
      , { join = True
        , list = Nothing
        }
      )
    , ( "color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "color-adjust"
      , { join = True
        , list = Nothing
        }
      )
    , ( "color-interpolation-filters"
      , { join = True
        , list = Nothing
        }
      )
    , ( "color-scheme"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-count"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-fill"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-gap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-rule"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-rule-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-rule-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-rule-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-span"
      , { join = True
        , list = Nothing
        }
      )
    , ( "column-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "columns"
      , { join = True
        , list = Nothing
        }
      )
    , ( "contain"
      , { join = True
        , list = Nothing
        }
      )
    , ( "content"
      , { join = True
        , list = Nothing
        }
      )
    , ( "continue"
      , { join = True
        , list = Nothing
        }
      )
    , ( "counter-increment"
      , { join = True
        , list = Nothing
        }
      )
    , ( "counter-reset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "counter-set"
      , { join = True
        , list = Nothing
        }
      )
    , ( "cue"
      , { join = True
        , list = Nothing
        }
      )
    , ( "cue-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "cue-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "cursor"
      , { join = True
        , list = Nothing
        }
      )
    , ( "direction"
      , { join = True
        , list = Nothing
        }
      )
    , ( "display"
      , { join = True
        , list = Nothing
        }
      )
    , ( "dominant-baseline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "elevation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "empty-cells"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-image"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-opacity"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-origin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-repeat"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-rule"
      , { join = True
        , list = Nothing
        }
      )
    , ( "fill-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "filter"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-basis"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-direction"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-flow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-grow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-shrink"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flex-wrap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "float"
      , { join = True
        , list = Nothing
        }
      )
    , ( "float-defer"
      , { join = True
        , list = Nothing
        }
      )
    , ( "float-offset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "float-reference"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flood-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flood-opacity"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flow-from"
      , { join = True
        , list = Nothing
        }
      )
    , ( "flow-into"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-family"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-feature-settings"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-kerning"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-language-override"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-optical-sizing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-palette"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-size-adjust"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-stretch"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-synthesis"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-synthesis-small-caps"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-synthesis-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-synthesis-weight"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-alternates"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-caps"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-east-asian"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-emoji"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-ligatures"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-numeric"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variant-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-variation-settings"
      , { join = True
        , list = Nothing
        }
      )
    , ( "font-weight"
      , { join = True
        , list = Nothing
        }
      )
    , ( "footnote-display"
      , { join = True
        , list = Nothing
        }
      )
    , ( "footnote-policy"
      , { join = True
        , list = Nothing
        }
      )
    , ( "forced-color-adjust"
      , { join = True
        , list = Nothing
        }
      )
    , ( "gap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "glyph-orientation-vertical"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-area"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-auto-columns"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-auto-flow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-auto-rows"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-column"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-column-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-column-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-row"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-row-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-row-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-template"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-template-areas"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-template-columns"
      , { join = True
        , list = Nothing
        }
      )
    , ( "grid-template-rows"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hanging-punctuation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "height"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphenate-character"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphenate-limit-chars"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphenate-limit-last"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphenate-limit-lines"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphenate-limit-zone"
      , { join = True
        , list = Nothing
        }
      )
    , ( "hyphens"
      , { join = True
        , list = Nothing
        }
      )
    , ( "image-orientation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "image-rendering"
      , { join = True
        , list = Nothing
        }
      )
    , ( "image-resolution"
      , { join = True
        , list = Nothing
        }
      )
    , ( "initial-letters"
      , { join = True
        , list = Nothing
        }
      )
    , ( "initial-letters-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "initial-letters-wrap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inline-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inline-sizing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "inset-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "isolation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "justify-content"
      , { join = True
        , list = Nothing
        }
      )
    , ( "justify-items"
      , { join = True
        , list = Nothing
        }
      )
    , ( "justify-self"
      , { join = True
        , list = Nothing
        }
      )
    , ( "left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "letter-spacing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "lighting-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-clamp"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-grid"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-height"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-height-step"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-padding"
      , { join = True
        , list = Nothing
        }
      )
    , ( "line-snap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "list-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "list-style-image"
      , { join = True
        , list = Nothing
        }
      )
    , ( "list-style-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "list-style-type"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "margin-trim"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-knockout-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-knockout-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-mid"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-pattern"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-segment"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-side"
      , { join = True
        , list = Nothing
        }
      )
    , ( "marker-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-mode"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-outset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-repeat"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-slice"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-source"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-border-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-clip"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-composite"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-image"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-mode"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-origin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-repeat"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mask-type"
      , { join = True
        , list = Nothing
        }
      )
    , ( "max-block-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "max-height"
      , { join = True
        , list = Nothing
        }
      )
    , ( "max-inline-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "max-lines"
      , { join = True
        , list = Nothing
        }
      )
    , ( "max-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "min-block-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "min-height"
      , { join = True
        , list = Nothing
        }
      )
    , ( "min-inline-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "min-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "mix-blend-mode"
      , { join = True
        , list = Nothing
        }
      )
    , ( "nav-down"
      , { join = True
        , list = Nothing
        }
      )
    , ( "nav-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "nav-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "nav-up"
      , { join = True
        , list = Nothing
        }
      )
    , ( "object-fit"
      , { join = True
        , list = Nothing
        }
      )
    , ( "object-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-anchor"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-distance"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-path"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-rotate"
      , { join = True
        , list = Nothing
        }
      )
    , ( "offset-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "opacity"
      , { join = True
        , list = Nothing
        }
      )
    , ( "order"
      , { join = True
        , list = Nothing
        }
      )
    , ( "orphans"
      , { join = True
        , list = Nothing
        }
      )
    , ( "outline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "outline-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "outline-offset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "outline-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "outline-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-anchor"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-wrap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-x"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overflow-y"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overscroll-behavior"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overscroll-behavior-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overscroll-behavior-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overscroll-behavior-x"
      , { join = True
        , list = Nothing
        }
      )
    , ( "overscroll-behavior-y"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "padding-top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "page"
      , { join = True
        , list = Nothing
        }
      )
    , ( "page-break-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "page-break-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "page-break-inside"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pause"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pause-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pause-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "perspective"
      , { join = True
        , list = Nothing
        }
      )
    , ( "perspective-origin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pitch"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pitch-range"
      , { join = True
        , list = Nothing
        }
      )
    , ( "place-content"
      , { join = True
        , list = Nothing
        }
      )
    , ( "place-items"
      , { join = True
        , list = Nothing
        }
      )
    , ( "place-self"
      , { join = True
        , list = Nothing
        }
      )
    , ( "play-during"
      , { join = True
        , list = Nothing
        }
      )
    , ( "pointer-events"
      , { join = True
        , list = Nothing
        }
      )
    , ( "position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "quotes"
      , { join = True
        , list = Nothing
        }
      )
    , ( "region-fragment"
      , { join = True
        , list = Nothing
        }
      )
    , ( "resize"
      , { join = True
        , list = Nothing
        }
      )
    , ( "rest"
      , { join = True
        , list = Nothing
        }
      )
    , ( "rest-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "rest-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "richness"
      , { join = True
        , list = Nothing
        }
      )
    , ( "right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "rotate"
      , { join = True
        , list = Nothing
        }
      )
    , ( "row-gap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "ruby-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "ruby-merge"
      , { join = True
        , list = Nothing
        }
      )
    , ( "ruby-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "running"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scale"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-behavior"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-margin-top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-block"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-block-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-block-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-bottom"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-inline"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-inline-end"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-inline-start"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-left"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-right"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-padding-top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-snap-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-snap-stop"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scroll-snap-type"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scrollbar-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scrollbar-gutter"
      , { join = True
        , list = Nothing
        }
      )
    , ( "scrollbar-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "shape-image-threshold"
      , { join = True
        , list = Nothing
        }
      )
    , ( "shape-inside"
      , { join = True
        , list = Nothing
        }
      )
    , ( "shape-margin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "shape-outside"
      , { join = True
        , list = Nothing
        }
      )
    , ( "spatial-navigation-action"
      , { join = True
        , list = Nothing
        }
      )
    , ( "spatial-navigation-contain"
      , { join = True
        , list = Nothing
        }
      )
    , ( "spatial-navigation-function"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speak"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speak-as"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speak-header"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speak-numeral"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speak-punctuation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "speech-rate"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stress"
      , { join = True
        , list = Nothing
        }
      )
    , ( "string-set"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-alignment"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dash-corner"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dash-justify"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dashadjust"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dasharray"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dashcorner"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-dashoffset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-image"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-linecap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-linejoin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-miterlimit"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-opacity"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-origin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-repeat"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "stroke-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "tab-size"
      , { join = True
        , list = Nothing
        }
      )
    , ( "table-layout"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-align-all"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-align-last"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-combine-upright"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-line"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-skip"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-skip-ink"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-decoration-width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-emphasis"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-emphasis-color"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-emphasis-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-emphasis-skip"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-emphasis-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-group-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-indent"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-justify"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-orientation"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-overflow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-shadow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-space-collapse"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-space-trim"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-spacing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-transform"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-underline-offset"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-underline-position"
      , { join = True
        , list = Nothing
        }
      )
    , ( "text-wrap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "top"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transform"
      , { join = True
        , list = Just Space
        }
      )
    , ( "transform-box"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transform-origin"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transform-style"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transition"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transition-delay"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transition-duration"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transition-property"
      , { join = True
        , list = Nothing
        }
      )
    , ( "transition-timing-function"
      , { join = True
        , list = Nothing
        }
      )
    , ( "translate"
      , { join = True
        , list = Nothing
        }
      )
    , ( "unicode-bidi"
      , { join = True
        , list = Nothing
        }
      )
    , ( "user-select"
      , { join = True
        , list = Nothing
        }
      )
    , ( "vertical-align"
      , { join = True
        , list = Nothing
        }
      )
    , ( "visibility"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-balance"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-duration"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-family"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-pitch"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-range"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-rate"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-stress"
      , { join = True
        , list = Nothing
        }
      )
    , ( "voice-volume"
      , { join = True
        , list = Nothing
        }
      )
    , ( "volume"
      , { join = True
        , list = Nothing
        }
      )
    , ( "white-space"
      , { join = True
        , list = Nothing
        }
      )
    , ( "widows"
      , { join = True
        , list = Nothing
        }
      )
    , ( "width"
      , { join = True
        , list = Nothing
        }
      )
    , ( "will-change"
      , { join = True
        , list = Nothing
        }
      )
    , ( "word-boundary-detection"
      , { join = True
        , list = Nothing
        }
      )
    , ( "word-boundary-expansion"
      , { join = True
        , list = Nothing
        }
      )
    , ( "word-break"
      , { join = True
        , list = Nothing
        }
      )
    , ( "word-spacing"
      , { join = True
        , list = Nothing
        }
      )
    , ( "word-wrap"
      , { join = True
        , list = Nothing
        }
      )
    , ( "wrap-after"
      , { join = True
        , list = Nothing
        }
      )
    , ( "wrap-before"
      , { join = True
        , list = Nothing
        }
      )
    , ( "wrap-flow"
      , { join = True
        , list = Nothing
        }
      )
    , ( "wrap-inside"
      , { join = True
        , list = Nothing
        }
      )
    , ( "wrap-through"
      , { join = True
        , list = Nothing
        }
      )
    , ( "writing-mode"
      , { join = True
        , list = Nothing
        }
      )
    , ( "z-index"
      , { join = True
        , list = Nothing
        }
      )
    ]
