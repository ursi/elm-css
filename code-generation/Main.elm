module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import List.Extra as List


main =
    -- view
    code


type alias Property =
    ( String, JoinType )


type JoinType
    = None
    | Space1
    | Space2
    | Comma1
    | Comma2


view : Html ()
view =
    table []
        [ thead []
            [ tr []
                [ td [] [ text "Property" ]
                , td [] [ text "Join Type" ]
                ]
            ]
        , tbody [] <|
            List.map toTr <|
                sort properties
        ]


toTr : Property -> Html ()
toTr ( property, joinType ) =
    tr []
        [ td [] [ text property ]
        , td []
            [ text
                (case joinType of
                    None ->
                        "None"

                    Space1 ->
                        "Space1"

                    Space2 ->
                        "Space2"

                    Comma1 ->
                        "Comma1"

                    Comma2 ->
                        "Comma2"
                )
            ]
        ]


code : Html ()
code =
    div [] <| List.map generateCode <| sort properties


generateCode : Property -> Html ()
generateCode ( property, joinType ) =
    div []
        [ pre []
            [ """
$ : String -> Declaration
$ = I.Single identity "#"
"""
                ++ (if joinType == Space1 || joinType == Space2 then
                        j " "
                            ++ (if joinType == Space2 then
                                    jj " "

                                else
                                    ""
                               )

                    else if joinType == Comma1 then
                        j ", "

                    else if joinType == Comma2 then
                        j " " ++ jj ", "

                    else
                        ""
                   )
                |> String.replace "$" (camelCase property)
                |> String.replace "#" property
                |> text
            ]
        ]


j : String -> String
j separator =
    String.replace
        "%"
        separator
        """
$J : List String -> Declaration
$J = I.Single identity "#" << String.join "%"
"""


jj : String -> String
jj separator =
    String.replace
        "%"
        separator
        """
$JJ : List (List String) -> Declaration
$JJ = I.Single identity "#" << String.join "%" << List.map (String.join " ")
"""


camelCase : String -> String
camelCase =
    String.split "-"
        >> List.map (somethingFirst String.toUpper)
        >> String.join ""
        >> somethingFirst String.toLower


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


sortList : List JoinType
sortList =
    [ Comma2, Space2, Comma1, Space1, None ]


sort : List Property -> List Property
sort =
    List.sortWith
        (\( property1, joinType1 ) ( property2, joinType2 ) ->
            let
                index1 =
                    getIndex joinType1

                index2 =
                    getIndex joinType2
            in
            if index1 < index2 then
                LT

            else if index1 > index2 then
                GT

            else if property1 < property2 then
                LT

            else
                GT
        )


getIndex : JoinType -> Int
getIndex =
    List.elemIndex
        >> (|>) sortList
        >> Maybe.withDefault -1


properties =
    [ ( "align-content"
      , Space1
      )
    , ( "align-items"
      , Space1
      )
    , ( "align-self"
      , Space1
      )
    , ( "alignment-baseline"
      , None
      )
    , ( "all"
      , None
      )
    , ( "animation"
      , Comma2
      )
    , ( "animation-delay"
      , Comma1
      )
    , ( "animation-direction"
      , Comma1
      )
    , ( "animation-duration"
      , Comma1
      )
    , ( "animation-fill-mode"
      , Comma1
      )
    , ( "animation-iteration-count"
      , Comma1
      )
    , ( "animation-name"
      , Comma1
      )
    , ( "animation-play-state"
      , Comma1
      )
    , ( "animation-timing-function"
      , Comma1
      )
    , ( "appearance"
      , None
      )
    , ( "azimuth"
      , Space1
      )
    , ( "backface-visibility"
      , None
      )
    , ( "background"
      , Comma2
      )
    , ( "background-attachment"
      , Comma1
      )
    , ( "background-blend-mode"
      , None
      )
    , ( "background-clip"
      , Comma1
      )
    , ( "background-color"
      , None
      )
    , ( "background-image"
      , Comma1
      )
    , ( "background-origin"
      , Comma1
      )
    , ( "background-position"
      , Space1
      )
    , ( "background-repeat"
      , Comma2
      )
    , ( "background-size"
      , Comma2
      )
    , ( "baseline-shift"
      , None
      )
    , ( "block-overflow"
      , None
      )
    , ( "block-size"
      , None
      )
    , ( "block-step"
      , Space1
      )
    , ( "block-step-align"
      , None
      )
    , ( "block-step-insert"
      , None
      )
    , ( "block-step-round"
      , None
      )
    , ( "block-step-size"
      , None
      )
    , ( "bookmark-label"
      , Space1
      )
    , ( "bookmark-level"
      , None
      )
    , ( "bookmark-state"
      , None
      )
    , ( "border"
      , Space1
      )
    , ( "border-block"
      , Space1
      )
    , ( "border-block-color"
      , Space1
      )
    , ( "border-block-end"
      , Space1
      )
    , ( "border-block-end-color"
      , None
      )
    , ( "border-block-end-style"
      , None
      )
    , ( "border-block-end-width"
      , None
      )
    , ( "border-block-start"
      , Space1
      )
    , ( "border-block-start-color"
      , None
      )
    , ( "border-block-start-style"
      , None
      )
    , ( "border-block-start-width"
      , None
      )
    , ( "border-block-style"
      , Space1
      )
    , ( "border-block-width"
      , Space1
      )
    , ( "border-bottom"
      , Space1
      )
    , ( "border-bottom-color"
      , None
      )
    , ( "border-bottom-left-radius"
      , Space1
      )
    , ( "border-bottom-right-radius"
      , Space1
      )
    , ( "border-bottom-style"
      , None
      )
    , ( "border-bottom-width"
      , None
      )
    , ( "border-boundary"
      , None
      )
    , ( "border-collapse"
      , None
      )
    , ( "border-color"
      , Space1
      )
    , ( "border-end-end-radius"
      , Space1
      )
    , ( "border-end-start-radius"
      , Space1
      )
    , ( "border-image"
      , Space1
      )
    , ( "border-image-outset"
      , Space1
      )
    , ( "border-image-repeat"
      , Space1
      )
    , ( "border-image-slice"
      , Space1
      )
    , ( "border-image-source"
      , None
      )
    , ( "border-image-width"
      , Space1
      )
    , ( "border-inline"
      , Space1
      )
    , ( "border-inline-color"
      , Space1
      )
    , ( "border-inline-end"
      , Space1
      )
    , ( "border-inline-end-color"
      , None
      )
    , ( "border-inline-end-style"
      , None
      )
    , ( "border-inline-end-width"
      , None
      )
    , ( "border-inline-start"
      , Space1
      )
    , ( "border-inline-start-color"
      , None
      )
    , ( "border-inline-start-style"
      , None
      )
    , ( "border-inline-start-width"
      , None
      )
    , ( "border-inline-style"
      , Space1
      )
    , ( "border-inline-width"
      , Space1
      )
    , ( "border-left"
      , Space1
      )
    , ( "border-left-color"
      , None
      )
    , ( "border-left-style"
      , None
      )
    , ( "border-left-width"
      , None
      )
    , ( "border-radius"
      , Space1
      )
    , ( "border-right"
      , Space1
      )
    , ( "border-right-color"
      , None
      )
    , ( "border-right-style"
      , None
      )
    , ( "border-right-width"
      , None
      )
    , ( "border-spacing"
      , Space1
      )
    , ( "border-start-end-radius"
      , Space1
      )
    , ( "border-start-start-radius"
      , Space1
      )
    , ( "border-style"
      , Space1
      )
    , ( "border-top"
      , Space1
      )
    , ( "border-top-color"
      , None
      )
    , ( "border-top-left-radius"
      , Space1
      )
    , ( "border-top-right-radius"
      , Space1
      )
    , ( "border-top-style"
      , None
      )
    , ( "border-top-width"
      , None
      )
    , ( "border-width"
      , Space1
      )
    , ( "bottom"
      , None
      )
    , ( "box-decoration-break"
      , None
      )
    , ( "box-shadow"
      , Comma2
      )
    , ( "box-sizing"
      , None
      )
    , ( "box-snap"
      , None
      )
    , ( "break-after"
      , None
      )
    , ( "break-before"
      , None
      )
    , ( "break-inside"
      , None
      )
    , ( "caption-side"
      , None
      )
    , ( "caret"
      , Space1
      )
    , ( "caret-color"
      , None
      )
    , ( "caret-shape"
      , None
      )
    , ( "clear"
      , None
      )
    , ( "clip"
      , None
      )
    , ( "clip-path"
      , Space1
      )
    , ( "clip-rule"
      , None
      )
    , ( "color"
      , None
      )
    , ( "color-adjust"
      , None
      )
    , ( "color-interpolation-filters"
      , None
      )
    , ( "color-scheme"
      , Space1
      )
    , ( "column-count"
      , None
      )
    , ( "column-fill"
      , None
      )
    , ( "column-gap"
      , None
      )
    , ( "column-rule"
      , Space1
      )
    , ( "column-rule-color"
      , None
      )
    , ( "column-rule-style"
      , None
      )
    , ( "column-rule-width"
      , None
      )
    , ( "column-span"
      , None
      )
    , ( "column-width"
      , None
      )
    , ( "columns"
      , Space1
      )
    , ( "contain"
      , Space1
      )
    , ( "content"
      , Space1
      )
    , ( "continue"
      , None
      )
    , ( "counter-increment"
      , Space2
      )
    , ( "counter-reset"
      , Space2
      )
    , ( "counter-set"
      , Space2
      )
    , ( "cue"
      , Space2
      )
    , ( "cue-after"
      , Space1
      )
    , ( "cue-before"
      , Space1
      )
    , ( "cursor"
      , Space2
      )
    , ( "direction"
      , None
      )
    , ( "display"
      , Space1
      )
    , ( "dominant-baseline"
      , None
      )
    , ( "elevation"
      , None
      )
    , ( "empty-cells"
      , None
      )
    , ( "fill"
      , Space1
      )
    , ( "fill-break"
      , None
      )
    , ( "fill-color"
      , None
      )
    , ( "fill-image"
      , Comma1
      )
    , ( "fill-opacity"
      , None
      )
    , ( "fill-origin"
      , None
      )
    , ( "fill-position"
      , Comma2
      )
    , ( "fill-repeat"
      , Comma2
      )
    , ( "fill-rule"
      , None
      )
    , ( "fill-size"
      , Comma2
      )
    , ( "filter"
      , Space1
      )
    , ( "flex"
      , Space1
      )
    , ( "flex-basis"
      , None
      )
    , ( "flex-direction"
      , None
      )
    , ( "flex-flow"
      , Space1
      )
    , ( "flex-grow"
        -- number
      , None
      )
    , ( "flex-shrink"
        -- number
      , None
      )
    , ( "flex-wrap"
      , None
      )
    , ( "float"
      , None
      )
    , ( "float-defer"
      , None
      )
    , ( "float-offset"
      , None
      )
    , ( "float-reference"
      , None
      )
    , ( "flood-color"
      , None
      )
    , ( "flood-opacity"
      , None
      )
    , ( "flow-from"
      , None
      )
    , ( "flow-into"
      , Space1
      )
    , ( "font"
      , Space1
      )
    , ( "font-family"
      , Comma1
      )
    , ( "font-feature-settings"
      , Comma2
      )
    , ( "font-kerning"
      , None
      )
    , ( "font-language-override"
      , None
      )
    , ( "font-optical-sizing"
      , None
      )
    , ( "font-palette"
      , None
      )
    , ( "font-size"
      , None
      )
    , ( "font-size-adjust"
      , None
      )
    , ( "font-stretch"
      , None
      )
    , ( "font-style"
      , Space1
      )
    , ( "font-synthesis"
      , Space1
      )
    , ( "font-synthesis-small-caps"
      , None
      )
    , ( "font-synthesis-style"
      , None
      )
    , ( "font-synthesis-weight"
      , None
      )
    , ( "font-variant"
      , Space1
      )
    , ( "font-variant-alternates"
      , Space1
      )
    , ( "font-variant-caps"
      , None
      )
    , ( "font-variant-east-asian"
      , Space1
      )
    , ( "font-variant-emoji"
      , None
      )
    , ( "font-variant-ligatures"
      , Space1
      )
    , ( "font-variant-numeric"
      , Space1
      )
    , ( "font-variant-position"
      , None
      )
    , ( "font-variation-settings"
      , Comma2
      )
    , ( "font-weight"
      , None
      )
    , ( "footnote-display"
      , None
      )
    , ( "footnote-policy"
      , None
      )
    , ( "forced-color-adjust"
      , None
      )
    , ( "gap"
      , Space1
      )
    , ( "glyph-orientation-vertical"
      , None
      )
    , ( "grid"
      , Space2
      )
    , ( "grid-area"
      , Space2
      )
    , ( "grid-auto-columns"
      , Space1
      )
    , ( "grid-auto-flow"
      , Space1
      )
    , ( "grid-auto-rows"
      , Space1
      )
    , ( "grid-column"
      , Space2
      )
    , ( "grid-column-end"
      , Space1
      )
    , ( "grid-column-start"
      , Space1
      )
    , ( "grid-row"
      , Space2
      )
    , ( "grid-row-end"
      , Space1
      )
    , ( "grid-row-start"
      , Space1
      )
    , ( "grid-template"
      , Space2
      )
    , ( "grid-template-areas"
      , Space1
      )
    , ( "grid-template-columns"
      , Space2
      )
    , ( "grid-template-rows"
      , Space2
      )
    , ( "hanging-punctuation"
      , Space1
      )
    , ( "height"
      , None
      )
    , ( "hyphenate-character"
      , None
      )
    , ( "hyphenate-limit-chars"
      , Space1
      )
    , ( "hyphenate-limit-last"
      , None
      )
    , ( "hyphenate-limit-lines"
      , None
      )
    , ( "hyphenate-limit-zone"
      , None
      )
    , ( "hyphens"
      , None
      )

    -- here
    , ( "image-orientation"
      , None
      )
    , ( "image-rendering"
      , None
      )
    , ( "image-resolution"
      , None
      )
    , ( "initial-letters"
      , None
      )
    , ( "initial-letters-align"
      , None
      )
    , ( "initial-letters-wrap"
      , None
      )
    , ( "inline-size"
      , None
      )
    , ( "inline-sizing"
      , None
      )
    , ( "inset"
      , None
      )
    , ( "inset-block"
      , None
      )
    , ( "inset-block-end"
      , None
      )
    , ( "inset-block-start"
      , None
      )
    , ( "inset-inline"
      , None
      )
    , ( "inset-inline-end"
      , None
      )
    , ( "inset-inline-start"
      , None
      )
    , ( "isolation"
      , None
      )
    , ( "justify-content"
      , None
      )
    , ( "justify-items"
      , None
      )
    , ( "justify-self"
      , None
      )
    , ( "left"
      , None
      )
    , ( "letter-spacing"
      , None
      )
    , ( "lighting-color"
      , None
      )
    , ( "line-break"
      , None
      )
    , ( "line-clamp"
      , None
      )
    , ( "line-grid"
      , None
      )
    , ( "line-height"
      , None
      )
    , ( "line-height-step"
      , None
      )
    , ( "line-padding"
      , None
      )
    , ( "line-snap"
      , None
      )
    , ( "list-style"
      , None
      )
    , ( "list-style-image"
      , None
      )
    , ( "list-style-position"
      , None
      )
    , ( "list-style-type"
      , None
      )
    , ( "margin"
      , None
      )
    , ( "margin-block"
      , None
      )
    , ( "margin-block-end"
      , None
      )
    , ( "margin-block-start"
      , None
      )
    , ( "margin-bottom"
      , None
      )
    , ( "margin-break"
      , None
      )
    , ( "margin-inline"
      , None
      )
    , ( "margin-inline-end"
      , None
      )
    , ( "margin-inline-start"
      , None
      )
    , ( "margin-left"
      , None
      )
    , ( "margin-right"
      , None
      )
    , ( "margin-top"
      , None
      )
    , ( "margin-trim"
      , None
      )
    , ( "marker"
      , None
      )
    , ( "marker-end"
      , None
      )
    , ( "marker-knockout-left"
      , None
      )
    , ( "marker-knockout-right"
      , None
      )
    , ( "marker-mid"
      , None
      )
    , ( "marker-pattern"
      , None
      )
    , ( "marker-segment"
      , None
      )
    , ( "marker-side"
      , None
      )
    , ( "marker-start"
      , None
      )
    , ( "mask"
      , None
      )
    , ( "mask-border"
      , None
      )
    , ( "mask-border-mode"
      , None
      )
    , ( "mask-border-outset"
      , None
      )
    , ( "mask-border-repeat"
      , None
      )
    , ( "mask-border-slice"
      , None
      )
    , ( "mask-border-source"
      , None
      )
    , ( "mask-border-width"
      , None
      )
    , ( "mask-clip"
      , None
      )
    , ( "mask-composite"
      , None
      )
    , ( "mask-image"
      , None
      )
    , ( "mask-mode"
      , None
      )
    , ( "mask-origin"
      , None
      )
    , ( "mask-position"
      , None
      )
    , ( "mask-repeat"
      , None
      )
    , ( "mask-size"
      , None
      )
    , ( "mask-type"
      , None
      )
    , ( "max-block-size"
      , None
      )
    , ( "max-height"
      , None
      )
    , ( "max-inline-size"
      , None
      )
    , ( "max-lines"
      , None
      )
    , ( "max-width"
      , None
      )
    , ( "min-block-size"
      , None
      )
    , ( "min-height"
      , None
      )
    , ( "min-inline-size"
      , None
      )
    , ( "min-width"
      , None
      )
    , ( "mix-blend-mode"
      , None
      )
    , ( "nav-down"
      , None
      )
    , ( "nav-left"
      , None
      )
    , ( "nav-right"
      , None
      )
    , ( "nav-up"
      , None
      )
    , ( "object-fit"
      , None
      )
    , ( "object-position"
      , None
      )
    , ( "offset"
      , None
      )
    , ( "offset-after"
      , None
      )
    , ( "offset-anchor"
      , None
      )
    , ( "offset-before"
      , None
      )
    , ( "offset-distance"
      , None
      )
    , ( "offset-end"
      , None
      )
    , ( "offset-path"
      , None
      )
    , ( "offset-position"
      , None
      )
    , ( "offset-rotate"
      , None
      )
    , ( "offset-start"
      , None
      )
    , ( "opacity"
      , None
      )
    , ( "order"
      , None
      )
    , ( "orphans"
      , None
      )
    , ( "outline"
      , None
      )
    , ( "outline-color"
      , None
      )
    , ( "outline-offset"
      , None
      )
    , ( "outline-style"
      , None
      )
    , ( "outline-width"
      , None
      )
    , ( "overflow"
      , None
      )
    , ( "overflow-anchor"
      , None
      )
    , ( "overflow-block"
      , None
      )
    , ( "overflow-inline"
      , None
      )
    , ( "overflow-wrap"
      , None
      )
    , ( "overflow-x"
      , None
      )
    , ( "overflow-y"
      , None
      )
    , ( "overscroll-behavior"
      , None
      )
    , ( "overscroll-behavior-block"
      , None
      )
    , ( "overscroll-behavior-inline"
      , None
      )
    , ( "overscroll-behavior-x"
      , None
      )
    , ( "overscroll-behavior-y"
      , None
      )
    , ( "padding"
      , None
      )
    , ( "padding-block"
      , None
      )
    , ( "padding-block-end"
      , None
      )
    , ( "padding-block-start"
      , None
      )
    , ( "padding-bottom"
      , None
      )
    , ( "padding-inline"
      , None
      )
    , ( "padding-inline-end"
      , None
      )
    , ( "padding-inline-start"
      , None
      )
    , ( "padding-left"
      , None
      )
    , ( "padding-right"
      , None
      )
    , ( "padding-top"
      , None
      )
    , ( "page"
      , None
      )
    , ( "page-break-after"
      , None
      )
    , ( "page-break-before"
      , None
      )
    , ( "page-break-inside"
      , None
      )
    , ( "pause"
      , None
      )
    , ( "pause-after"
      , None
      )
    , ( "pause-before"
      , None
      )
    , ( "perspective"
      , None
      )
    , ( "perspective-origin"
      , None
      )
    , ( "pitch"
      , None
      )
    , ( "pitch-range"
      , None
      )
    , ( "place-content"
      , None
      )
    , ( "place-items"
      , None
      )
    , ( "place-self"
      , None
      )
    , ( "play-during"
      , None
      )
    , ( "pointer-events"
      , None
      )
    , ( "position"
      , None
      )
    , ( "quotes"
      , None
      )
    , ( "region-fragment"
      , None
      )
    , ( "resize"
      , None
      )
    , ( "rest"
      , None
      )
    , ( "rest-after"
      , None
      )
    , ( "rest-before"
      , None
      )
    , ( "richness"
      , None
      )
    , ( "right"
      , None
      )
    , ( "rotate"
      , None
      )
    , ( "row-gap"
      , None
      )
    , ( "ruby-align"
      , None
      )
    , ( "ruby-merge"
      , None
      )
    , ( "ruby-position"
      , None
      )
    , ( "running"
      , None
      )
    , ( "scale"
      , None
      )
    , ( "scroll-behavior"
      , None
      )
    , ( "scroll-margin"
      , None
      )
    , ( "scroll-margin-block"
      , None
      )
    , ( "scroll-margin-block-end"
      , None
      )
    , ( "scroll-margin-block-start"
      , None
      )
    , ( "scroll-margin-bottom"
      , None
      )
    , ( "scroll-margin-inline"
      , None
      )
    , ( "scroll-margin-inline-end"
      , None
      )
    , ( "scroll-margin-inline-start"
      , None
      )
    , ( "scroll-margin-left"
      , None
      )
    , ( "scroll-margin-right"
      , None
      )
    , ( "scroll-margin-top"
      , None
      )
    , ( "scroll-padding"
      , None
      )
    , ( "scroll-padding-block"
      , None
      )
    , ( "scroll-padding-block-end"
      , None
      )
    , ( "scroll-padding-block-start"
      , None
      )
    , ( "scroll-padding-bottom"
      , None
      )
    , ( "scroll-padding-inline"
      , None
      )
    , ( "scroll-padding-inline-end"
      , None
      )
    , ( "scroll-padding-inline-start"
      , None
      )
    , ( "scroll-padding-left"
      , None
      )
    , ( "scroll-padding-right"
      , None
      )
    , ( "scroll-padding-top"
      , None
      )
    , ( "scroll-snap-align"
      , None
      )
    , ( "scroll-snap-stop"
      , None
      )
    , ( "scroll-snap-type"
      , None
      )
    , ( "scrollbar-color"
      , None
      )
    , ( "scrollbar-gutter"
      , None
      )
    , ( "scrollbar-width"
      , None
      )
    , ( "shape-image-threshold"
      , None
      )
    , ( "shape-inside"
      , None
      )
    , ( "shape-margin"
      , None
      )
    , ( "shape-outside"
      , None
      )
    , ( "spatial-navigation-action"
      , None
      )
    , ( "spatial-navigation-contain"
      , None
      )
    , ( "spatial-navigation-function"
      , None
      )
    , ( "speak"
      , None
      )
    , ( "speak-as"
      , None
      )
    , ( "speak-header"
      , None
      )
    , ( "speak-numeral"
      , None
      )
    , ( "speak-punctuation"
      , None
      )
    , ( "speech-rate"
      , None
      )
    , ( "stress"
      , None
      )
    , ( "string-set"
      , None
      )
    , ( "stroke"
      , None
      )
    , ( "stroke-align"
      , None
      )
    , ( "stroke-alignment"
      , None
      )
    , ( "stroke-break"
      , None
      )
    , ( "stroke-color"
      , None
      )
    , ( "stroke-dash-corner"
      , None
      )
    , ( "stroke-dash-justify"
      , None
      )
    , ( "stroke-dashadjust"
      , None
      )
    , ( "stroke-dasharray"
      , None
      )
    , ( "stroke-dashcorner"
      , None
      )
    , ( "stroke-dashoffset"
      , None
      )
    , ( "stroke-image"
      , None
      )
    , ( "stroke-linecap"
      , None
      )
    , ( "stroke-linejoin"
      , None
      )
    , ( "stroke-miterlimit"
      , None
      )
    , ( "stroke-opacity"
      , None
      )
    , ( "stroke-origin"
      , None
      )
    , ( "stroke-position"
      , None
      )
    , ( "stroke-repeat"
      , None
      )
    , ( "stroke-size"
      , None
      )
    , ( "stroke-width"
      , None
      )
    , ( "tab-size"
      , None
      )
    , ( "table-layout"
      , None
      )
    , ( "text-align"
      , None
      )
    , ( "text-align-all"
      , None
      )
    , ( "text-align-last"
      , None
      )
    , ( "text-combine-upright"
      , None
      )
    , ( "text-decoration"
      , None
      )
    , ( "text-decoration-color"
      , None
      )
    , ( "text-decoration-line"
      , None
      )
    , ( "text-decoration-skip"
      , None
      )
    , ( "text-decoration-skip-ink"
      , None
      )
    , ( "text-decoration-style"
      , None
      )
    , ( "text-decoration-width"
      , None
      )
    , ( "text-emphasis"
      , None
      )
    , ( "text-emphasis-color"
      , None
      )
    , ( "text-emphasis-position"
      , None
      )
    , ( "text-emphasis-skip"
      , None
      )
    , ( "text-emphasis-style"
      , None
      )
    , ( "text-group-align"
      , None
      )
    , ( "text-indent"
      , None
      )
    , ( "text-justify"
      , None
      )
    , ( "text-orientation"
      , None
      )
    , ( "text-overflow"
      , None
      )
    , ( "text-shadow"
      , None
      )
    , ( "text-space-collapse"
      , None
      )
    , ( "text-space-trim"
      , None
      )
    , ( "text-spacing"
      , None
      )
    , ( "text-transform"
      , None
      )
    , ( "text-underline-offset"
      , None
      )
    , ( "text-underline-position"
      , None
      )
    , ( "text-wrap"
      , None
      )
    , ( "top"
      , None
      )
    , ( "transform"
      , Space1
      )
    , ( "transform-box"
      , None
      )
    , ( "transform-origin"
      , None
      )
    , ( "transform-style"
      , None
      )
    , ( "transition"
      , Comma2
      )
    , ( "transition-delay"
      , Comma1
      )
    , ( "transition-duration"
      , Comma1
      )
    , ( "transition-property"
      , Comma1
      )
    , ( "transition-timing-function"
      , Comma1
      )
    , ( "translate"
      , None
      )
    , ( "unicode-bidi"
      , None
      )
    , ( "user-select"
      , None
      )
    , ( "vertical-align"
      , None
      )
    , ( "visibility"
      , None
      )
    , ( "voice-balance"
      , None
      )
    , ( "voice-duration"
      , None
      )
    , ( "voice-family"
      , None
      )
    , ( "voice-pitch"
      , None
      )
    , ( "voice-range"
      , None
      )
    , ( "voice-rate"
      , None
      )
    , ( "voice-stress"
      , None
      )
    , ( "voice-volume"
      , None
      )
    , ( "volume"
      , None
      )
    , ( "white-space"
      , None
      )
    , ( "widows"
      , None
      )
    , ( "width"
      , None
      )
    , ( "will-change"
      , None
      )
    , ( "word-boundary-detection"
      , None
      )
    , ( "word-boundary-expansion"
      , None
      )
    , ( "word-break"
      , None
      )
    , ( "word-spacing"
      , None
      )
    , ( "word-wrap"
      , None
      )
    , ( "wrap-after"
      , None
      )
    , ( "wrap-before"
      , None
      )
    , ( "wrap-flow"
      , None
      )
    , ( "wrap-inside"
      , None
      )
    , ( "wrap-through"
      , None
      )
    , ( "writing-mode"
      , None
      )
    , ( "z-index"
      , None
      )
    ]
