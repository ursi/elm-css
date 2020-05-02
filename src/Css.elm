module Css exposing (..)

import Css.Internal as I


todo =
    Debug.todo ""


type alias Declaration =
    I.Declaration


declaration : String -> String -> Declaration
declaration =
    I.Single identity


batch : List Declaration -> Declaration
batch =
    I.Batch


mapSelector : (String -> String) -> List Declaration -> Declaration
mapSelector classToSelector =
    List.map
        (\declaration_ ->
            case declaration_ of
                I.Single currentClassToSelector property value ->
                    I.Single
                        (currentClassToSelector << classToSelector)
                        property
                        value

                I.Batch declarations ->
                    mapSelector classToSelector declarations
        )
        >> I.Batch


append : String -> String -> String
append =
    (>>) (++) << (|>)


adjacent : List Declaration -> Declaration
adjacent =
    mapSelector (\class -> class ++ " + " ++ class)


child : String -> List Declaration -> Declaration
child tag =
    mapSelector <| append <| " > " ++ tag


children : List Declaration -> Declaration
children =
    mapSelector <| append " > *"


descendant : String -> List Declaration -> Declaration
descendant tag =
    mapSelector <| append <| " " ++ tag


descendants : List Declaration -> Declaration
descendants =
    mapSelector <| append " *"



-- Structural pseudo-classes
-- https://drafts.csswg.org/selectors-3/#structural-pseudos
-- these pseudo-classes are the reason style elements aren't inserted in the element they're attached to


root : List Declaration -> Declaration
root =
    mapSelector <| append ":root"


nthChild : Int -> Int -> List Declaration -> Declaration
nthChild a b =
    anpb a b
        |> I.function ":nth-child"
        |> append
        |> mapSelector


nthLastChild : Int -> Int -> List Declaration -> Declaration
nthLastChild a b =
    anpb a b
        |> I.function ":nth-last-child"
        |> append
        |> mapSelector


nthOfType : Int -> Int -> List Declaration -> Declaration
nthOfType a b =
    anpb a b
        |> I.function ":nth-of-type"
        |> append
        |> mapSelector


nthLastOfType : Int -> Int -> List Declaration -> Declaration
nthLastOfType a b =
    anpb a b
        |> I.function ":nth-last-of-type"
        |> append
        |> mapSelector


firstChild : List Declaration -> Declaration
firstChild =
    mapSelector <| append ":first-child"


lastChild : List Declaration -> Declaration
lastChild =
    mapSelector <| append ":last-child"


firstOfType : List Declaration -> Declaration
firstOfType =
    mapSelector <| append ":first-of-type"


lastOfType : List Declaration -> Declaration
lastOfType =
    mapSelector <| append ":last-of-type"


onlyChild : List Declaration -> Declaration
onlyChild =
    mapSelector <| append ":only-child"


onlyOfType : List Declaration -> Declaration
onlyOfType =
    mapSelector <| append ":only-of-type"


empty : List Declaration -> Declaration
empty =
    mapSelector <| append ":empty"


anpb : Int -> Int -> String
anpb a b =
    String.fromInt a
        ++ "n+"
        ++ String.fromInt b



--


hover : List Declaration -> Declaration
hover =
    mapSelector <| append ":hover"


important : Declaration -> Declaration
important declaration_ =
    case declaration_ of
        I.Single f p value ->
            I.Single f p <| append " !important" value

        I.Batch declarations ->
            I.Batch <| List.map important declarations



-- Properties


order : Int -> Declaration
order =
    I.Single identity "order" << String.fromInt


orphans : Int -> Declaration
orphans =
    I.Single identity "orphans" << String.fromInt


widows : Int -> Declaration
widows =
    I.Single identity "widows" << String.fromInt


flexGrow : Float -> Declaration
flexGrow =
    I.Single identity "flex-grow" << String.fromFloat


flexShrink : Float -> Declaration
flexShrink =
    I.Single identity "flex-shrink" << String.fromFloat


shapeImageThreshold : Float -> Declaration
shapeImageThreshold =
    I.Single identity "shape-image-threshold" << String.fromFloat


strokeMiterlimit : Float -> Declaration
strokeMiterlimit =
    I.Single identity "stroke-miterlimit" << String.fromFloat


animation : String -> Declaration
animation =
    I.Single identity "animation"


animationJ : List String -> Declaration
animationJ =
    I.Single identity "animation" << String.join " "


animationJJ : List (List String) -> Declaration
animationJJ =
    I.Single identity "animation" << String.join ", " << List.map (String.join " ")


background : String -> Declaration
background =
    I.Single identity "background"


backgroundJ : List String -> Declaration
backgroundJ =
    I.Single identity "background" << String.join " "


backgroundJJ : List (List String) -> Declaration
backgroundJJ =
    I.Single identity "background" << String.join ", " << List.map (String.join " ")


backgroundRepeat : String -> Declaration
backgroundRepeat =
    I.Single identity "background-repeat"


backgroundRepeatJ : List String -> Declaration
backgroundRepeatJ =
    I.Single identity "background-repeat" << String.join " "


backgroundRepeatJJ : List (List String) -> Declaration
backgroundRepeatJJ =
    I.Single identity "background-repeat" << String.join ", " << List.map (String.join " ")


backgroundSize : String -> Declaration
backgroundSize =
    I.Single identity "background-size"


backgroundSizeJ : List String -> Declaration
backgroundSizeJ =
    I.Single identity "background-size" << String.join " "


backgroundSizeJJ : List (List String) -> Declaration
backgroundSizeJJ =
    I.Single identity "background-size" << String.join ", " << List.map (String.join " ")


boxShadow : String -> Declaration
boxShadow =
    I.Single identity "box-shadow"


boxShadowJ : List String -> Declaration
boxShadowJ =
    I.Single identity "box-shadow" << String.join " "


boxShadowJJ : List (List String) -> Declaration
boxShadowJJ =
    I.Single identity "box-shadow" << String.join ", " << List.map (String.join " ")


fillPosition : String -> Declaration
fillPosition =
    I.Single identity "fill-position"


fillPositionJ : List String -> Declaration
fillPositionJ =
    I.Single identity "fill-position" << String.join " "


fillPositionJJ : List (List String) -> Declaration
fillPositionJJ =
    I.Single identity "fill-position" << String.join ", " << List.map (String.join " ")


fillRepeat : String -> Declaration
fillRepeat =
    I.Single identity "fill-repeat"


fillRepeatJ : List String -> Declaration
fillRepeatJ =
    I.Single identity "fill-repeat" << String.join " "


fillRepeatJJ : List (List String) -> Declaration
fillRepeatJJ =
    I.Single identity "fill-repeat" << String.join ", " << List.map (String.join " ")


fillSize : String -> Declaration
fillSize =
    I.Single identity "fill-size"


fillSizeJ : List String -> Declaration
fillSizeJ =
    I.Single identity "fill-size" << String.join " "


fillSizeJJ : List (List String) -> Declaration
fillSizeJJ =
    I.Single identity "fill-size" << String.join ", " << List.map (String.join " ")


fontFeatureSettings : String -> Declaration
fontFeatureSettings =
    I.Single identity "font-feature-settings"


fontFeatureSettingsJ : List String -> Declaration
fontFeatureSettingsJ =
    I.Single identity "font-feature-settings" << String.join " "


fontFeatureSettingsJJ : List (List String) -> Declaration
fontFeatureSettingsJJ =
    I.Single identity "font-feature-settings" << String.join ", " << List.map (String.join " ")


fontVariationSettings : String -> Declaration
fontVariationSettings =
    I.Single identity "font-variation-settings"


fontVariationSettingsJ : List String -> Declaration
fontVariationSettingsJ =
    I.Single identity "font-variation-settings" << String.join " "


fontVariationSettingsJJ : List (List String) -> Declaration
fontVariationSettingsJJ =
    I.Single identity "font-variation-settings" << String.join ", " << List.map (String.join " ")


mask : String -> Declaration
mask =
    I.Single identity "mask"


maskJ : List String -> Declaration
maskJ =
    I.Single identity "mask" << String.join " "


maskJJ : List (List String) -> Declaration
maskJJ =
    I.Single identity "mask" << String.join ", " << List.map (String.join " ")


stringSet : String -> Declaration
stringSet =
    I.Single identity "string-set"


stringSetJ : List String -> Declaration
stringSetJ =
    I.Single identity "string-set" << String.join " "


stringSetJJ : List (List String) -> Declaration
stringSetJJ =
    I.Single identity "string-set" << String.join ", " << List.map (String.join " ")


stroke : String -> Declaration
stroke =
    I.Single identity "stroke"


strokeJ : List String -> Declaration
strokeJ =
    I.Single identity "stroke" << String.join " "


strokeJJ : List (List String) -> Declaration
strokeJJ =
    I.Single identity "stroke" << String.join ", " << List.map (String.join " ")


strokeDasharray : String -> Declaration
strokeDasharray =
    I.Single identity "stroke-dasharray"


strokeDasharrayJ : List String -> Declaration
strokeDasharrayJ =
    I.Single identity "stroke-dasharray" << String.join " "


strokeDasharrayJJ : List (List String) -> Declaration
strokeDasharrayJJ =
    I.Single identity "stroke-dasharray" << String.join ", " << List.map (String.join " ")


strokePosition : String -> Declaration
strokePosition =
    I.Single identity "stroke-position"


strokePositionJ : List String -> Declaration
strokePositionJ =
    I.Single identity "stroke-position" << String.join " "


strokePositionJJ : List (List String) -> Declaration
strokePositionJJ =
    I.Single identity "stroke-position" << String.join ", " << List.map (String.join " ")


strokeRepeat : String -> Declaration
strokeRepeat =
    I.Single identity "stroke-repeat"


strokeRepeatJ : List String -> Declaration
strokeRepeatJ =
    I.Single identity "stroke-repeat" << String.join " "


strokeRepeatJJ : List (List String) -> Declaration
strokeRepeatJJ =
    I.Single identity "stroke-repeat" << String.join ", " << List.map (String.join " ")


strokeSize : String -> Declaration
strokeSize =
    I.Single identity "stroke-size"


strokeSizeJ : List String -> Declaration
strokeSizeJ =
    I.Single identity "stroke-size" << String.join " "


strokeSizeJJ : List (List String) -> Declaration
strokeSizeJJ =
    I.Single identity "stroke-size" << String.join ", " << List.map (String.join " ")


textShadow : String -> Declaration
textShadow =
    I.Single identity "text-shadow"


textShadowJ : List String -> Declaration
textShadowJ =
    I.Single identity "text-shadow" << String.join " "


textShadowJJ : List (List String) -> Declaration
textShadowJJ =
    I.Single identity "text-shadow" << String.join ", " << List.map (String.join " ")


transition : String -> Declaration
transition =
    I.Single identity "transition"


transitionJ : List String -> Declaration
transitionJ =
    I.Single identity "transition" << String.join " "


transitionJJ : List (List String) -> Declaration
transitionJJ =
    I.Single identity "transition" << String.join ", " << List.map (String.join " ")


voiceFamily : String -> Declaration
voiceFamily =
    I.Single identity "voice-family"


voiceFamilyJ : List String -> Declaration
voiceFamilyJ =
    I.Single identity "voice-family" << String.join " "


voiceFamilyJJ : List (List String) -> Declaration
voiceFamilyJJ =
    I.Single identity "voice-family" << String.join ", " << List.map (String.join " ")


counterIncrement : String -> Declaration
counterIncrement =
    I.Single identity "counter-increment"


counterIncrementJ : List String -> Declaration
counterIncrementJ =
    I.Single identity "counter-increment" << String.join " "


counterIncrementJJ : List (List String) -> Declaration
counterIncrementJJ =
    I.Single identity "counter-increment" << String.join " " << List.map (String.join " ")


counterReset : String -> Declaration
counterReset =
    I.Single identity "counter-reset"


counterResetJ : List String -> Declaration
counterResetJ =
    I.Single identity "counter-reset" << String.join " "


counterResetJJ : List (List String) -> Declaration
counterResetJJ =
    I.Single identity "counter-reset" << String.join " " << List.map (String.join " ")


counterSet : String -> Declaration
counterSet =
    I.Single identity "counter-set"


counterSetJ : List String -> Declaration
counterSetJ =
    I.Single identity "counter-set" << String.join " "


counterSetJJ : List (List String) -> Declaration
counterSetJJ =
    I.Single identity "counter-set" << String.join " " << List.map (String.join " ")


cue : String -> Declaration
cue =
    I.Single identity "cue"


cueJ : List String -> Declaration
cueJ =
    I.Single identity "cue" << String.join " "


cueJJ : List (List String) -> Declaration
cueJJ =
    I.Single identity "cue" << String.join " " << List.map (String.join " ")


cursor : String -> Declaration
cursor =
    I.Single identity "cursor"


cursorJ : List String -> Declaration
cursorJ =
    I.Single identity "cursor" << String.join " "


cursorJJ : List (List String) -> Declaration
cursorJJ =
    I.Single identity "cursor" << String.join " " << List.map (String.join " ")


grid : String -> Declaration
grid =
    I.Single identity "grid"


gridJ : List String -> Declaration
gridJ =
    I.Single identity "grid" << String.join " "


gridJJ : List (List String) -> Declaration
gridJJ =
    I.Single identity "grid" << String.join " " << List.map (String.join " ")


gridArea : String -> Declaration
gridArea =
    I.Single identity "grid-area"


gridAreaJ : List String -> Declaration
gridAreaJ =
    I.Single identity "grid-area" << String.join " "


gridAreaJJ : List (List String) -> Declaration
gridAreaJJ =
    I.Single identity "grid-area" << String.join " " << List.map (String.join " ")


gridColumn : String -> Declaration
gridColumn =
    I.Single identity "grid-column"


gridColumnJ : List String -> Declaration
gridColumnJ =
    I.Single identity "grid-column" << String.join " "


gridColumnJJ : List (List String) -> Declaration
gridColumnJJ =
    I.Single identity "grid-column" << String.join " " << List.map (String.join " ")


gridRow : String -> Declaration
gridRow =
    I.Single identity "grid-row"


gridRowJ : List String -> Declaration
gridRowJ =
    I.Single identity "grid-row" << String.join " "


gridRowJJ : List (List String) -> Declaration
gridRowJJ =
    I.Single identity "grid-row" << String.join " " << List.map (String.join " ")


gridTemplate : String -> Declaration
gridTemplate =
    I.Single identity "grid-template"


gridTemplateJ : List String -> Declaration
gridTemplateJ =
    I.Single identity "grid-template" << String.join " "


gridTemplateJJ : List (List String) -> Declaration
gridTemplateJJ =
    I.Single identity "grid-template" << String.join " " << List.map (String.join " ")


gridTemplateColumns : String -> Declaration
gridTemplateColumns =
    I.Single identity "grid-template-columns"


gridTemplateColumnsJ : List String -> Declaration
gridTemplateColumnsJ =
    I.Single identity "grid-template-columns" << String.join " "


gridTemplateColumnsJJ : List (List String) -> Declaration
gridTemplateColumnsJJ =
    I.Single identity "grid-template-columns" << String.join " " << List.map (String.join " ")


gridTemplateRows : String -> Declaration
gridTemplateRows =
    I.Single identity "grid-template-rows"


gridTemplateRowsJ : List String -> Declaration
gridTemplateRowsJ =
    I.Single identity "grid-template-rows" << String.join " "


gridTemplateRowsJJ : List (List String) -> Declaration
gridTemplateRowsJJ =
    I.Single identity "grid-template-rows" << String.join " " << List.map (String.join " ")


markerPattern : String -> Declaration
markerPattern =
    I.Single identity "marker-pattern"


markerPatternJ : List String -> Declaration
markerPatternJ =
    I.Single identity "marker-pattern" << String.join " "


markerPatternJJ : List (List String) -> Declaration
markerPatternJJ =
    I.Single identity "marker-pattern" << String.join " " << List.map (String.join " ")


maskBorder : String -> Declaration
maskBorder =
    I.Single identity "mask-border"


maskBorderJ : List String -> Declaration
maskBorderJ =
    I.Single identity "mask-border" << String.join " "


maskBorderJJ : List (List String) -> Declaration
maskBorderJJ =
    I.Single identity "mask-border" << String.join " " << List.map (String.join " ")


maskBorderSlice : String -> Declaration
maskBorderSlice =
    I.Single identity "mask-border-slice"


maskBorderSliceJ : List String -> Declaration
maskBorderSliceJ =
    I.Single identity "mask-border-slice" << String.join " "


maskBorderSliceJJ : List (List String) -> Declaration
maskBorderSliceJJ =
    I.Single identity "mask-border-slice" << String.join " " << List.map (String.join " ")


offset : String -> Declaration
offset =
    I.Single identity "offset"


offsetJ : List String -> Declaration
offsetJ =
    I.Single identity "offset" << String.join " "


offsetJJ : List (List String) -> Declaration
offsetJJ =
    I.Single identity "offset" << String.join " " << List.map (String.join " ")


quotes : String -> Declaration
quotes =
    I.Single identity "quotes"


quotesJ : List String -> Declaration
quotesJ =
    I.Single identity "quotes" << String.join " "


quotesJJ : List (List String) -> Declaration
quotesJJ =
    I.Single identity "quotes" << String.join " " << List.map (String.join " ")


textDecoration : String -> Declaration
textDecoration =
    I.Single identity "text-decoration"


textDecorationJ : List String -> Declaration
textDecorationJ =
    I.Single identity "text-decoration" << String.join " "


textDecorationJJ : List (List String) -> Declaration
textDecorationJJ =
    I.Single identity "text-decoration" << String.join " " << List.map (String.join " ")


textEmphasis : String -> Declaration
textEmphasis =
    I.Single identity "text-emphasis"


textEmphasisJ : List String -> Declaration
textEmphasisJ =
    I.Single identity "text-emphasis" << String.join " "


textEmphasisJJ : List (List String) -> Declaration
textEmphasisJJ =
    I.Single identity "text-emphasis" << String.join " " << List.map (String.join " ")


animationDelay : String -> Declaration
animationDelay =
    I.Single identity "animation-delay"


animationDelayJ : List String -> Declaration
animationDelayJ =
    I.Single identity "animation-delay" << String.join ", "


animationDirection : String -> Declaration
animationDirection =
    I.Single identity "animation-direction"


animationDirectionJ : List String -> Declaration
animationDirectionJ =
    I.Single identity "animation-direction" << String.join ", "


animationDuration : String -> Declaration
animationDuration =
    I.Single identity "animation-duration"


animationDurationJ : List String -> Declaration
animationDurationJ =
    I.Single identity "animation-duration" << String.join ", "


animationFillMode : String -> Declaration
animationFillMode =
    I.Single identity "animation-fill-mode"


animationFillModeJ : List String -> Declaration
animationFillModeJ =
    I.Single identity "animation-fill-mode" << String.join ", "


animationIterationCount : String -> Declaration
animationIterationCount =
    I.Single identity "animation-iteration-count"


animationIterationCountJ : List String -> Declaration
animationIterationCountJ =
    I.Single identity "animation-iteration-count" << String.join ", "


animationName : String -> Declaration
animationName =
    I.Single identity "animation-name"


animationNameJ : List String -> Declaration
animationNameJ =
    I.Single identity "animation-name" << String.join ", "


animationPlayState : String -> Declaration
animationPlayState =
    I.Single identity "animation-play-state"


animationPlayStateJ : List String -> Declaration
animationPlayStateJ =
    I.Single identity "animation-play-state" << String.join ", "


animationTimingFunction : String -> Declaration
animationTimingFunction =
    I.Single identity "animation-timing-function"


animationTimingFunctionJ : List String -> Declaration
animationTimingFunctionJ =
    I.Single identity "animation-timing-function" << String.join ", "


backgroundAttachment : String -> Declaration
backgroundAttachment =
    I.Single identity "background-attachment"


backgroundAttachmentJ : List String -> Declaration
backgroundAttachmentJ =
    I.Single identity "background-attachment" << String.join ", "


backgroundClip : String -> Declaration
backgroundClip =
    I.Single identity "background-clip"


backgroundClipJ : List String -> Declaration
backgroundClipJ =
    I.Single identity "background-clip" << String.join ", "


backgroundImage : String -> Declaration
backgroundImage =
    I.Single identity "background-image"


backgroundImageJ : List String -> Declaration
backgroundImageJ =
    I.Single identity "background-image" << String.join ", "


backgroundOrigin : String -> Declaration
backgroundOrigin =
    I.Single identity "background-origin"


backgroundOriginJ : List String -> Declaration
backgroundOriginJ =
    I.Single identity "background-origin" << String.join ", "


fillImage : String -> Declaration
fillImage =
    I.Single identity "fill-image"


fillImageJ : List String -> Declaration
fillImageJ =
    I.Single identity "fill-image" << String.join ", "


fontFamily : String -> Declaration
fontFamily =
    I.Single identity "font-family"


fontFamilyJ : List String -> Declaration
fontFamilyJ =
    I.Single identity "font-family" << String.join ", "


maskClip : String -> Declaration
maskClip =
    I.Single identity "mask-clip"


maskClipJ : List String -> Declaration
maskClipJ =
    I.Single identity "mask-clip" << String.join ", "


maskComposite : String -> Declaration
maskComposite =
    I.Single identity "mask-composite"


maskCompositeJ : List String -> Declaration
maskCompositeJ =
    I.Single identity "mask-composite" << String.join ", "


maskImage : String -> Declaration
maskImage =
    I.Single identity "mask-image"


maskImageJ : List String -> Declaration
maskImageJ =
    I.Single identity "mask-image" << String.join ", "


maskMode : String -> Declaration
maskMode =
    I.Single identity "mask-mode"


maskModeJ : List String -> Declaration
maskModeJ =
    I.Single identity "mask-mode" << String.join ", "


maskOrigin : String -> Declaration
maskOrigin =
    I.Single identity "mask-origin"


maskOriginJ : List String -> Declaration
maskOriginJ =
    I.Single identity "mask-origin" << String.join ", "


maskPosition : String -> Declaration
maskPosition =
    I.Single identity "mask-position"


maskPositionJ : List String -> Declaration
maskPositionJ =
    I.Single identity "mask-position" << String.join ", "


maskRepeat : String -> Declaration
maskRepeat =
    I.Single identity "mask-repeat"


maskRepeatJ : List String -> Declaration
maskRepeatJ =
    I.Single identity "mask-repeat" << String.join ", "


maskSize : String -> Declaration
maskSize =
    I.Single identity "mask-size"


maskSizeJ : List String -> Declaration
maskSizeJ =
    I.Single identity "mask-size" << String.join ", "


strokeColor : String -> Declaration
strokeColor =
    I.Single identity "stroke-color"


strokeColorJ : List String -> Declaration
strokeColorJ =
    I.Single identity "stroke-color" << String.join ", "


strokeImage : String -> Declaration
strokeImage =
    I.Single identity "stroke-image"


strokeImageJ : List String -> Declaration
strokeImageJ =
    I.Single identity "stroke-image" << String.join ", "


strokeWidth : String -> Declaration
strokeWidth =
    I.Single identity "stroke-width"


strokeWidthJ : List String -> Declaration
strokeWidthJ =
    I.Single identity "stroke-width" << String.join ", "


transitionDelay : String -> Declaration
transitionDelay =
    I.Single identity "transition-delay"


transitionDelayJ : List String -> Declaration
transitionDelayJ =
    I.Single identity "transition-delay" << String.join ", "


transitionDuration : String -> Declaration
transitionDuration =
    I.Single identity "transition-duration"


transitionDurationJ : List String -> Declaration
transitionDurationJ =
    I.Single identity "transition-duration" << String.join ", "


transitionProperty : String -> Declaration
transitionProperty =
    I.Single identity "transition-property"


transitionPropertyJ : List String -> Declaration
transitionPropertyJ =
    I.Single identity "transition-property" << String.join ", "


transitionTimingFunction : String -> Declaration
transitionTimingFunction =
    I.Single identity "transition-timing-function"


transitionTimingFunctionJ : List String -> Declaration
transitionTimingFunctionJ =
    I.Single identity "transition-timing-function" << String.join ", "


willChange : String -> Declaration
willChange =
    I.Single identity "will-change"


willChangeJ : List String -> Declaration
willChangeJ =
    I.Single identity "will-change" << String.join ", "


alignContent : String -> Declaration
alignContent =
    I.Single identity "align-content"


alignContentJ : List String -> Declaration
alignContentJ =
    I.Single identity "align-content" << String.join " "


alignItems : String -> Declaration
alignItems =
    I.Single identity "align-items"


alignItemsJ : List String -> Declaration
alignItemsJ =
    I.Single identity "align-items" << String.join " "


alignSelf : String -> Declaration
alignSelf =
    I.Single identity "align-self"


alignSelfJ : List String -> Declaration
alignSelfJ =
    I.Single identity "align-self" << String.join " "


azimuth : String -> Declaration
azimuth =
    I.Single identity "azimuth"


azimuthJ : List String -> Declaration
azimuthJ =
    I.Single identity "azimuth" << String.join " "


backgroundPosition : String -> Declaration
backgroundPosition =
    I.Single identity "background-position"


backgroundPositionJ : List String -> Declaration
backgroundPositionJ =
    I.Single identity "background-position" << String.join " "


blockStep : String -> Declaration
blockStep =
    I.Single identity "block-step"


blockStepJ : List String -> Declaration
blockStepJ =
    I.Single identity "block-step" << String.join " "


bookmarkLabel : String -> Declaration
bookmarkLabel =
    I.Single identity "bookmark-label"


bookmarkLabelJ : List String -> Declaration
bookmarkLabelJ =
    I.Single identity "bookmark-label" << String.join " "


border : String -> Declaration
border =
    I.Single identity "border"


borderJ : List String -> Declaration
borderJ =
    I.Single identity "border" << String.join " "


borderBlock : String -> Declaration
borderBlock =
    I.Single identity "border-block"


borderBlockJ : List String -> Declaration
borderBlockJ =
    I.Single identity "border-block" << String.join " "


borderBlockColor : String -> Declaration
borderBlockColor =
    I.Single identity "border-block-color"


borderBlockColorJ : List String -> Declaration
borderBlockColorJ =
    I.Single identity "border-block-color" << String.join " "


borderBlockEnd : String -> Declaration
borderBlockEnd =
    I.Single identity "border-block-end"


borderBlockEndJ : List String -> Declaration
borderBlockEndJ =
    I.Single identity "border-block-end" << String.join " "


borderBlockStart : String -> Declaration
borderBlockStart =
    I.Single identity "border-block-start"


borderBlockStartJ : List String -> Declaration
borderBlockStartJ =
    I.Single identity "border-block-start" << String.join " "


borderBlockStyle : String -> Declaration
borderBlockStyle =
    I.Single identity "border-block-style"


borderBlockStyleJ : List String -> Declaration
borderBlockStyleJ =
    I.Single identity "border-block-style" << String.join " "


borderBlockWidth : String -> Declaration
borderBlockWidth =
    I.Single identity "border-block-width"


borderBlockWidthJ : List String -> Declaration
borderBlockWidthJ =
    I.Single identity "border-block-width" << String.join " "


borderBottom : String -> Declaration
borderBottom =
    I.Single identity "border-bottom"


borderBottomJ : List String -> Declaration
borderBottomJ =
    I.Single identity "border-bottom" << String.join " "


borderBottomLeftRadius : String -> Declaration
borderBottomLeftRadius =
    I.Single identity "border-bottom-left-radius"


borderBottomLeftRadiusJ : List String -> Declaration
borderBottomLeftRadiusJ =
    I.Single identity "border-bottom-left-radius" << String.join " "


borderBottomRightRadius : String -> Declaration
borderBottomRightRadius =
    I.Single identity "border-bottom-right-radius"


borderBottomRightRadiusJ : List String -> Declaration
borderBottomRightRadiusJ =
    I.Single identity "border-bottom-right-radius" << String.join " "


borderColor : String -> Declaration
borderColor =
    I.Single identity "border-color"


borderColorJ : List String -> Declaration
borderColorJ =
    I.Single identity "border-color" << String.join " "


borderEndEndRadius : String -> Declaration
borderEndEndRadius =
    I.Single identity "border-end-end-radius"


borderEndEndRadiusJ : List String -> Declaration
borderEndEndRadiusJ =
    I.Single identity "border-end-end-radius" << String.join " "


borderEndStartRadius : String -> Declaration
borderEndStartRadius =
    I.Single identity "border-end-start-radius"


borderEndStartRadiusJ : List String -> Declaration
borderEndStartRadiusJ =
    I.Single identity "border-end-start-radius" << String.join " "


borderImage : String -> Declaration
borderImage =
    I.Single identity "border-image"


borderImageJ : List String -> Declaration
borderImageJ =
    I.Single identity "border-image" << String.join " "


borderImageOutset : String -> Declaration
borderImageOutset =
    I.Single identity "border-image-outset"


borderImageOutsetJ : List String -> Declaration
borderImageOutsetJ =
    I.Single identity "border-image-outset" << String.join " "


borderImageRepeat : String -> Declaration
borderImageRepeat =
    I.Single identity "border-image-repeat"


borderImageRepeatJ : List String -> Declaration
borderImageRepeatJ =
    I.Single identity "border-image-repeat" << String.join " "


borderImageSlice : String -> Declaration
borderImageSlice =
    I.Single identity "border-image-slice"


borderImageSliceJ : List String -> Declaration
borderImageSliceJ =
    I.Single identity "border-image-slice" << String.join " "


borderImageWidth : String -> Declaration
borderImageWidth =
    I.Single identity "border-image-width"


borderImageWidthJ : List String -> Declaration
borderImageWidthJ =
    I.Single identity "border-image-width" << String.join " "


borderInline : String -> Declaration
borderInline =
    I.Single identity "border-inline"


borderInlineJ : List String -> Declaration
borderInlineJ =
    I.Single identity "border-inline" << String.join " "


borderInlineColor : String -> Declaration
borderInlineColor =
    I.Single identity "border-inline-color"


borderInlineColorJ : List String -> Declaration
borderInlineColorJ =
    I.Single identity "border-inline-color" << String.join " "


borderInlineEnd : String -> Declaration
borderInlineEnd =
    I.Single identity "border-inline-end"


borderInlineEndJ : List String -> Declaration
borderInlineEndJ =
    I.Single identity "border-inline-end" << String.join " "


borderInlineStart : String -> Declaration
borderInlineStart =
    I.Single identity "border-inline-start"


borderInlineStartJ : List String -> Declaration
borderInlineStartJ =
    I.Single identity "border-inline-start" << String.join " "


borderInlineStyle : String -> Declaration
borderInlineStyle =
    I.Single identity "border-inline-style"


borderInlineStyleJ : List String -> Declaration
borderInlineStyleJ =
    I.Single identity "border-inline-style" << String.join " "


borderInlineWidth : String -> Declaration
borderInlineWidth =
    I.Single identity "border-inline-width"


borderInlineWidthJ : List String -> Declaration
borderInlineWidthJ =
    I.Single identity "border-inline-width" << String.join " "


borderLeft : String -> Declaration
borderLeft =
    I.Single identity "border-left"


borderLeftJ : List String -> Declaration
borderLeftJ =
    I.Single identity "border-left" << String.join " "


borderRadius : String -> Declaration
borderRadius =
    I.Single identity "border-radius"


borderRadiusJ : List String -> Declaration
borderRadiusJ =
    I.Single identity "border-radius" << String.join " "


borderRight : String -> Declaration
borderRight =
    I.Single identity "border-right"


borderRightJ : List String -> Declaration
borderRightJ =
    I.Single identity "border-right" << String.join " "


borderSpacing : String -> Declaration
borderSpacing =
    I.Single identity "border-spacing"


borderSpacingJ : List String -> Declaration
borderSpacingJ =
    I.Single identity "border-spacing" << String.join " "


borderStartEndRadius : String -> Declaration
borderStartEndRadius =
    I.Single identity "border-start-end-radius"


borderStartEndRadiusJ : List String -> Declaration
borderStartEndRadiusJ =
    I.Single identity "border-start-end-radius" << String.join " "


borderStartStartRadius : String -> Declaration
borderStartStartRadius =
    I.Single identity "border-start-start-radius"


borderStartStartRadiusJ : List String -> Declaration
borderStartStartRadiusJ =
    I.Single identity "border-start-start-radius" << String.join " "


borderStyle : String -> Declaration
borderStyle =
    I.Single identity "border-style"


borderStyleJ : List String -> Declaration
borderStyleJ =
    I.Single identity "border-style" << String.join " "


borderTop : String -> Declaration
borderTop =
    I.Single identity "border-top"


borderTopJ : List String -> Declaration
borderTopJ =
    I.Single identity "border-top" << String.join " "


borderTopLeftRadius : String -> Declaration
borderTopLeftRadius =
    I.Single identity "border-top-left-radius"


borderTopLeftRadiusJ : List String -> Declaration
borderTopLeftRadiusJ =
    I.Single identity "border-top-left-radius" << String.join " "


borderTopRightRadius : String -> Declaration
borderTopRightRadius =
    I.Single identity "border-top-right-radius"


borderTopRightRadiusJ : List String -> Declaration
borderTopRightRadiusJ =
    I.Single identity "border-top-right-radius" << String.join " "


borderWidth : String -> Declaration
borderWidth =
    I.Single identity "border-width"


borderWidthJ : List String -> Declaration
borderWidthJ =
    I.Single identity "border-width" << String.join " "


caret : String -> Declaration
caret =
    I.Single identity "caret"


caretJ : List String -> Declaration
caretJ =
    I.Single identity "caret" << String.join " "


clipPath : String -> Declaration
clipPath =
    I.Single identity "clip-path"


clipPathJ : List String -> Declaration
clipPathJ =
    I.Single identity "clip-path" << String.join " "


colorScheme : String -> Declaration
colorScheme =
    I.Single identity "color-scheme"


colorSchemeJ : List String -> Declaration
colorSchemeJ =
    I.Single identity "color-scheme" << String.join " "


columnRule : String -> Declaration
columnRule =
    I.Single identity "column-rule"


columnRuleJ : List String -> Declaration
columnRuleJ =
    I.Single identity "column-rule" << String.join " "


columns : String -> Declaration
columns =
    I.Single identity "columns"


columnsJ : List String -> Declaration
columnsJ =
    I.Single identity "columns" << String.join " "


contain : String -> Declaration
contain =
    I.Single identity "contain"


containJ : List String -> Declaration
containJ =
    I.Single identity "contain" << String.join " "


content : String -> Declaration
content =
    I.Single identity "content"


contentJ : List String -> Declaration
contentJ =
    I.Single identity "content" << String.join " "


cueAfter : String -> Declaration
cueAfter =
    I.Single identity "cue-after"


cueAfterJ : List String -> Declaration
cueAfterJ =
    I.Single identity "cue-after" << String.join " "


cueBefore : String -> Declaration
cueBefore =
    I.Single identity "cue-before"


cueBeforeJ : List String -> Declaration
cueBeforeJ =
    I.Single identity "cue-before" << String.join " "


display : String -> Declaration
display =
    I.Single identity "display"


displayJ : List String -> Declaration
displayJ =
    I.Single identity "display" << String.join " "


fill : String -> Declaration
fill =
    I.Single identity "fill"


fillJ : List String -> Declaration
fillJ =
    I.Single identity "fill" << String.join " "


filter : String -> Declaration
filter =
    I.Single identity "filter"


filterJ : List String -> Declaration
filterJ =
    I.Single identity "filter" << String.join " "


flex : String -> Declaration
flex =
    I.Single identity "flex"


flexJ : List String -> Declaration
flexJ =
    I.Single identity "flex" << String.join " "


flexFlow : String -> Declaration
flexFlow =
    I.Single identity "flex-flow"


flexFlowJ : List String -> Declaration
flexFlowJ =
    I.Single identity "flex-flow" << String.join " "


flowInto : String -> Declaration
flowInto =
    I.Single identity "flow-into"


flowIntoJ : List String -> Declaration
flowIntoJ =
    I.Single identity "flow-into" << String.join " "


font : String -> Declaration
font =
    I.Single identity "font"


fontJ : List String -> Declaration
fontJ =
    I.Single identity "font" << String.join " "


fontStyle : String -> Declaration
fontStyle =
    I.Single identity "font-style"


fontStyleJ : List String -> Declaration
fontStyleJ =
    I.Single identity "font-style" << String.join " "


fontSynthesis : String -> Declaration
fontSynthesis =
    I.Single identity "font-synthesis"


fontSynthesisJ : List String -> Declaration
fontSynthesisJ =
    I.Single identity "font-synthesis" << String.join " "


fontVariant : String -> Declaration
fontVariant =
    I.Single identity "font-variant"


fontVariantJ : List String -> Declaration
fontVariantJ =
    I.Single identity "font-variant" << String.join " "


fontVariantAlternates : String -> Declaration
fontVariantAlternates =
    I.Single identity "font-variant-alternates"


fontVariantAlternatesJ : List String -> Declaration
fontVariantAlternatesJ =
    I.Single identity "font-variant-alternates" << String.join " "


fontVariantEastAsian : String -> Declaration
fontVariantEastAsian =
    I.Single identity "font-variant-east-asian"


fontVariantEastAsianJ : List String -> Declaration
fontVariantEastAsianJ =
    I.Single identity "font-variant-east-asian" << String.join " "


fontVariantLigatures : String -> Declaration
fontVariantLigatures =
    I.Single identity "font-variant-ligatures"


fontVariantLigaturesJ : List String -> Declaration
fontVariantLigaturesJ =
    I.Single identity "font-variant-ligatures" << String.join " "


fontVariantNumeric : String -> Declaration
fontVariantNumeric =
    I.Single identity "font-variant-numeric"


fontVariantNumericJ : List String -> Declaration
fontVariantNumericJ =
    I.Single identity "font-variant-numeric" << String.join " "


gap : String -> Declaration
gap =
    I.Single identity "gap"


gapJ : List String -> Declaration
gapJ =
    I.Single identity "gap" << String.join " "


gridAutoColumns : String -> Declaration
gridAutoColumns =
    I.Single identity "grid-auto-columns"


gridAutoColumnsJ : List String -> Declaration
gridAutoColumnsJ =
    I.Single identity "grid-auto-columns" << String.join " "


gridAutoFlow : String -> Declaration
gridAutoFlow =
    I.Single identity "grid-auto-flow"


gridAutoFlowJ : List String -> Declaration
gridAutoFlowJ =
    I.Single identity "grid-auto-flow" << String.join " "


gridAutoRows : String -> Declaration
gridAutoRows =
    I.Single identity "grid-auto-rows"


gridAutoRowsJ : List String -> Declaration
gridAutoRowsJ =
    I.Single identity "grid-auto-rows" << String.join " "


gridColumnEnd : String -> Declaration
gridColumnEnd =
    I.Single identity "grid-column-end"


gridColumnEndJ : List String -> Declaration
gridColumnEndJ =
    I.Single identity "grid-column-end" << String.join " "


gridColumnStart : String -> Declaration
gridColumnStart =
    I.Single identity "grid-column-start"


gridColumnStartJ : List String -> Declaration
gridColumnStartJ =
    I.Single identity "grid-column-start" << String.join " "


gridRowEnd : String -> Declaration
gridRowEnd =
    I.Single identity "grid-row-end"


gridRowEndJ : List String -> Declaration
gridRowEndJ =
    I.Single identity "grid-row-end" << String.join " "


gridRowStart : String -> Declaration
gridRowStart =
    I.Single identity "grid-row-start"


gridRowStartJ : List String -> Declaration
gridRowStartJ =
    I.Single identity "grid-row-start" << String.join " "


gridTemplateAreas : String -> Declaration
gridTemplateAreas =
    I.Single identity "grid-template-areas"


gridTemplateAreasJ : List String -> Declaration
gridTemplateAreasJ =
    I.Single identity "grid-template-areas" << String.join " "


hangingPunctuation : String -> Declaration
hangingPunctuation =
    I.Single identity "hanging-punctuation"


hangingPunctuationJ : List String -> Declaration
hangingPunctuationJ =
    I.Single identity "hanging-punctuation" << String.join " "


hyphenateLimitChars : String -> Declaration
hyphenateLimitChars =
    I.Single identity "hyphenate-limit-chars"


hyphenateLimitCharsJ : List String -> Declaration
hyphenateLimitCharsJ =
    I.Single identity "hyphenate-limit-chars" << String.join " "


imageOrientation : String -> Declaration
imageOrientation =
    I.Single identity "image-orientation"


imageOrientationJ : List String -> Declaration
imageOrientationJ =
    I.Single identity "image-orientation" << String.join " "


imageResolution : String -> Declaration
imageResolution =
    I.Single identity "image-resolution"


imageResolutionJ : List String -> Declaration
imageResolutionJ =
    I.Single identity "image-resolution" << String.join " "


initialLetters : String -> Declaration
initialLetters =
    I.Single identity "initial-letters"


initialLettersJ : List String -> Declaration
initialLettersJ =
    I.Single identity "initial-letters" << String.join " "


initialLettersAlign : String -> Declaration
initialLettersAlign =
    I.Single identity "initial-letters-align"


initialLettersAlignJ : List String -> Declaration
initialLettersAlignJ =
    I.Single identity "initial-letters-align" << String.join " "


inset : String -> Declaration
inset =
    I.Single identity "inset"


insetJ : List String -> Declaration
insetJ =
    I.Single identity "inset" << String.join " "


insetBlock : String -> Declaration
insetBlock =
    I.Single identity "inset-block"


insetBlockJ : List String -> Declaration
insetBlockJ =
    I.Single identity "inset-block" << String.join " "


insetInline : String -> Declaration
insetInline =
    I.Single identity "inset-inline"


insetInlineJ : List String -> Declaration
insetInlineJ =
    I.Single identity "inset-inline" << String.join " "


justifyContent : String -> Declaration
justifyContent =
    I.Single identity "justify-content"


justifyContentJ : List String -> Declaration
justifyContentJ =
    I.Single identity "justify-content" << String.join " "


justifyItems : String -> Declaration
justifyItems =
    I.Single identity "justify-items"


justifyItemsJ : List String -> Declaration
justifyItemsJ =
    I.Single identity "justify-items" << String.join " "


justifySelf : String -> Declaration
justifySelf =
    I.Single identity "justify-self"


justifySelfJ : List String -> Declaration
justifySelfJ =
    I.Single identity "justify-self" << String.join " "


lineClamp : String -> Declaration
lineClamp =
    I.Single identity "line-clamp"


lineClampJ : List String -> Declaration
lineClampJ =
    I.Single identity "line-clamp" << String.join " "


listStyle : String -> Declaration
listStyle =
    I.Single identity "list-style"


listStyleJ : List String -> Declaration
listStyleJ =
    I.Single identity "list-style" << String.join " "


margin : String -> Declaration
margin =
    I.Single identity "margin"


marginJ : List String -> Declaration
marginJ =
    I.Single identity "margin" << String.join " "


marginBlock : String -> Declaration
marginBlock =
    I.Single identity "margin-block"


marginBlockJ : List String -> Declaration
marginBlockJ =
    I.Single identity "margin-block" << String.join " "


marginInline : String -> Declaration
marginInline =
    I.Single identity "margin-inline"


marginInlineJ : List String -> Declaration
marginInlineJ =
    I.Single identity "margin-inline" << String.join " "


marker : String -> Declaration
marker =
    I.Single identity "marker"


markerJ : List String -> Declaration
markerJ =
    I.Single identity "marker" << String.join " "


markerKnockoutLeft : String -> Declaration
markerKnockoutLeft =
    I.Single identity "marker-knockout-left"


markerKnockoutLeftJ : List String -> Declaration
markerKnockoutLeftJ =
    I.Single identity "marker-knockout-left" << String.join " "


markerKnockoutRight : String -> Declaration
markerKnockoutRight =
    I.Single identity "marker-knockout-right"


markerKnockoutRightJ : List String -> Declaration
markerKnockoutRightJ =
    I.Single identity "marker-knockout-right" << String.join " "


maskBorderOutset : String -> Declaration
maskBorderOutset =
    I.Single identity "mask-border-outset"


maskBorderOutsetJ : List String -> Declaration
maskBorderOutsetJ =
    I.Single identity "mask-border-outset" << String.join " "


maskBorderRepeat : String -> Declaration
maskBorderRepeat =
    I.Single identity "mask-border-repeat"


maskBorderRepeatJ : List String -> Declaration
maskBorderRepeatJ =
    I.Single identity "mask-border-repeat" << String.join " "


maskBorderWidth : String -> Declaration
maskBorderWidth =
    I.Single identity "mask-border-width"


maskBorderWidthJ : List String -> Declaration
maskBorderWidthJ =
    I.Single identity "mask-border-width" << String.join " "


navDown : String -> Declaration
navDown =
    I.Single identity "nav-down"


navDownJ : List String -> Declaration
navDownJ =
    I.Single identity "nav-down" << String.join " "


navLeft : String -> Declaration
navLeft =
    I.Single identity "nav-left"


navLeftJ : List String -> Declaration
navLeftJ =
    I.Single identity "nav-left" << String.join " "


navRight : String -> Declaration
navRight =
    I.Single identity "nav-right"


navRightJ : List String -> Declaration
navRightJ =
    I.Single identity "nav-right" << String.join " "


navUp : String -> Declaration
navUp =
    I.Single identity "nav-up"


navUpJ : List String -> Declaration
navUpJ =
    I.Single identity "nav-up" << String.join " "


objectPosition : String -> Declaration
objectPosition =
    I.Single identity "object-position"


objectPositionJ : List String -> Declaration
objectPositionJ =
    I.Single identity "object-position" << String.join " "


offsetAnchor : String -> Declaration
offsetAnchor =
    I.Single identity "offset-anchor"


offsetAnchorJ : List String -> Declaration
offsetAnchorJ =
    I.Single identity "offset-anchor" << String.join " "


offsetPath : String -> Declaration
offsetPath =
    I.Single identity "offset-path"


offsetPathJ : List String -> Declaration
offsetPathJ =
    I.Single identity "offset-path" << String.join " "


offsetPosition : String -> Declaration
offsetPosition =
    I.Single identity "offset-position"


offsetPositionJ : List String -> Declaration
offsetPositionJ =
    I.Single identity "offset-position" << String.join " "


outline : String -> Declaration
outline =
    I.Single identity "outline"


outlineJ : List String -> Declaration
outlineJ =
    I.Single identity "outline" << String.join " "


overflow : String -> Declaration
overflow =
    I.Single identity "overflow"


overflowJ : List String -> Declaration
overflowJ =
    I.Single identity "overflow" << String.join " "


overflowBlock : String -> Declaration
overflowBlock =
    I.Single identity "overflow-block"


overflowBlockJ : List String -> Declaration
overflowBlockJ =
    I.Single identity "overflow-block" << String.join " "


overflowInline : String -> Declaration
overflowInline =
    I.Single identity "overflow-inline"


overflowInlineJ : List String -> Declaration
overflowInlineJ =
    I.Single identity "overflow-inline" << String.join " "


overscrollBehavior : String -> Declaration
overscrollBehavior =
    I.Single identity "overscroll-behavior"


overscrollBehaviorJ : List String -> Declaration
overscrollBehaviorJ =
    I.Single identity "overscroll-behavior" << String.join " "


padding : String -> Declaration
padding =
    I.Single identity "padding"


paddingJ : List String -> Declaration
paddingJ =
    I.Single identity "padding" << String.join " "


paddingBlock : String -> Declaration
paddingBlock =
    I.Single identity "padding-block"


paddingBlockJ : List String -> Declaration
paddingBlockJ =
    I.Single identity "padding-block" << String.join " "


paddingInline : String -> Declaration
paddingInline =
    I.Single identity "padding-inline"


paddingInlineJ : List String -> Declaration
paddingInlineJ =
    I.Single identity "padding-inline" << String.join " "


pause : String -> Declaration
pause =
    I.Single identity "pause"


pauseJ : List String -> Declaration
pauseJ =
    I.Single identity "pause" << String.join " "


perspectiveOrigin : String -> Declaration
perspectiveOrigin =
    I.Single identity "perspective-origin"


perspectiveOriginJ : List String -> Declaration
perspectiveOriginJ =
    I.Single identity "perspective-origin" << String.join " "


placeContent : String -> Declaration
placeContent =
    I.Single identity "place-content"


placeContentJ : List String -> Declaration
placeContentJ =
    I.Single identity "place-content" << String.join " "


placeItems : String -> Declaration
placeItems =
    I.Single identity "place-items"


placeItemsJ : List String -> Declaration
placeItemsJ =
    I.Single identity "place-items" << String.join " "


placeSelf : String -> Declaration
placeSelf =
    I.Single identity "place-self"


placeSelfJ : List String -> Declaration
placeSelfJ =
    I.Single identity "place-self" << String.join " "


playDuring : String -> Declaration
playDuring =
    I.Single identity "play-during"


playDuringJ : List String -> Declaration
playDuringJ =
    I.Single identity "play-during" << String.join " "


rest : String -> Declaration
rest =
    I.Single identity "rest"


restJ : List String -> Declaration
restJ =
    I.Single identity "rest" << String.join " "


rotate : String -> Declaration
rotate =
    I.Single identity "rotate"


rotateJ : List String -> Declaration
rotateJ =
    I.Single identity "rotate" << String.join " "


rubyAlign : String -> Declaration
rubyAlign =
    I.Single identity "ruby-align"


rubyAlignJ : List String -> Declaration
rubyAlignJ =
    I.Single identity "ruby-align" << String.join " "


rubyPosition : String -> Declaration
rubyPosition =
    I.Single identity "ruby-position"


rubyPositionJ : List String -> Declaration
rubyPositionJ =
    I.Single identity "ruby-position" << String.join " "


scale : String -> Declaration
scale =
    I.Single identity "scale"


scaleJ : List String -> Declaration
scaleJ =
    I.Single identity "scale" << String.join " "


scrollMargin : String -> Declaration
scrollMargin =
    I.Single identity "scroll-margin"


scrollMarginJ : List String -> Declaration
scrollMarginJ =
    I.Single identity "scroll-margin" << String.join " "


scrollMarginBlock : String -> Declaration
scrollMarginBlock =
    I.Single identity "scroll-margin-block"


scrollMarginBlockJ : List String -> Declaration
scrollMarginBlockJ =
    I.Single identity "scroll-margin-block" << String.join " "


scrollMarginInline : String -> Declaration
scrollMarginInline =
    I.Single identity "scroll-margin-inline"


scrollMarginInlineJ : List String -> Declaration
scrollMarginInlineJ =
    I.Single identity "scroll-margin-inline" << String.join " "


scrollPadding : String -> Declaration
scrollPadding =
    I.Single identity "scroll-padding"


scrollPaddingJ : List String -> Declaration
scrollPaddingJ =
    I.Single identity "scroll-padding" << String.join " "


scrollPaddingBlock : String -> Declaration
scrollPaddingBlock =
    I.Single identity "scroll-padding-block"


scrollPaddingBlockJ : List String -> Declaration
scrollPaddingBlockJ =
    I.Single identity "scroll-padding-block" << String.join " "


scrollPaddingInline : String -> Declaration
scrollPaddingInline =
    I.Single identity "scroll-padding-inline"


scrollPaddingInlineJ : List String -> Declaration
scrollPaddingInlineJ =
    I.Single identity "scroll-padding-inline" << String.join " "


scrollSnapAlign : String -> Declaration
scrollSnapAlign =
    I.Single identity "scroll-snap-align"


scrollSnapAlignJ : List String -> Declaration
scrollSnapAlignJ =
    I.Single identity "scroll-snap-align" << String.join " "


scrollSnapType : String -> Declaration
scrollSnapType =
    I.Single identity "scroll-snap-type"


scrollSnapTypeJ : List String -> Declaration
scrollSnapTypeJ =
    I.Single identity "scroll-snap-type" << String.join " "


scrollbarColor : String -> Declaration
scrollbarColor =
    I.Single identity "scrollbar-color"


scrollbarColorJ : List String -> Declaration
scrollbarColorJ =
    I.Single identity "scrollbar-color" << String.join " "


scrollbarGutter : String -> Declaration
scrollbarGutter =
    I.Single identity "scrollbar-gutter"


scrollbarGutterJ : List String -> Declaration
scrollbarGutterJ =
    I.Single identity "scrollbar-gutter" << String.join " "


shapeInside : String -> Declaration
shapeInside =
    I.Single identity "shape-inside"


shapeInsideJ : List String -> Declaration
shapeInsideJ =
    I.Single identity "shape-inside" << String.join " "


shapeOutside : String -> Declaration
shapeOutside =
    I.Single identity "shape-outside"


shapeOutsideJ : List String -> Declaration
shapeOutsideJ =
    I.Single identity "shape-outside" << String.join " "


speakAs : String -> Declaration
speakAs =
    I.Single identity "speak-as"


speakAsJ : List String -> Declaration
speakAsJ =
    I.Single identity "speak-as" << String.join " "


strokeDashJustify : String -> Declaration
strokeDashJustify =
    I.Single identity "stroke-dash-justify"


strokeDashJustifyJ : List String -> Declaration
strokeDashJustifyJ =
    I.Single identity "stroke-dash-justify" << String.join " "


strokeDashadjust : String -> Declaration
strokeDashadjust =
    I.Single identity "stroke-dashadjust"


strokeDashadjustJ : List String -> Declaration
strokeDashadjustJ =
    I.Single identity "stroke-dashadjust" << String.join " "


strokeLinejoin : String -> Declaration
strokeLinejoin =
    I.Single identity "stroke-linejoin"


strokeLinejoinJ : List String -> Declaration
strokeLinejoinJ =
    I.Single identity "stroke-linejoin" << String.join " "


textCombineUpright : String -> Declaration
textCombineUpright =
    I.Single identity "text-combine-upright"


textCombineUprightJ : List String -> Declaration
textCombineUprightJ =
    I.Single identity "text-combine-upright" << String.join " "


textDecorationLine : String -> Declaration
textDecorationLine =
    I.Single identity "text-decoration-line"


textDecorationLineJ : List String -> Declaration
textDecorationLineJ =
    I.Single identity "text-decoration-line" << String.join " "


textDecorationSkip : String -> Declaration
textDecorationSkip =
    I.Single identity "text-decoration-skip"


textDecorationSkipJ : List String -> Declaration
textDecorationSkipJ =
    I.Single identity "text-decoration-skip" << String.join " "


textEmphasisPosition : String -> Declaration
textEmphasisPosition =
    I.Single identity "text-emphasis-position"


textEmphasisPositionJ : List String -> Declaration
textEmphasisPositionJ =
    I.Single identity "text-emphasis-position" << String.join " "


textEmphasisSkip : String -> Declaration
textEmphasisSkip =
    I.Single identity "text-emphasis-skip"


textEmphasisSkipJ : List String -> Declaration
textEmphasisSkipJ =
    I.Single identity "text-emphasis-skip" << String.join " "


textEmphasisStyle : String -> Declaration
textEmphasisStyle =
    I.Single identity "text-emphasis-style"


textEmphasisStyleJ : List String -> Declaration
textEmphasisStyleJ =
    I.Single identity "text-emphasis-style" << String.join " "


textIndent : String -> Declaration
textIndent =
    I.Single identity "text-indent"


textIndentJ : List String -> Declaration
textIndentJ =
    I.Single identity "text-indent" << String.join " "


textSpaceTrim : String -> Declaration
textSpaceTrim =
    I.Single identity "text-space-trim"


textSpaceTrimJ : List String -> Declaration
textSpaceTrimJ =
    I.Single identity "text-space-trim" << String.join " "


textSpacing : String -> Declaration
textSpacing =
    I.Single identity "text-spacing"


textSpacingJ : List String -> Declaration
textSpacingJ =
    I.Single identity "text-spacing" << String.join " "


textTransform : String -> Declaration
textTransform =
    I.Single identity "text-transform"


textTransformJ : List String -> Declaration
textTransformJ =
    I.Single identity "text-transform" << String.join " "


textUnderlinePosition : String -> Declaration
textUnderlinePosition =
    I.Single identity "text-underline-position"


textUnderlinePositionJ : List String -> Declaration
textUnderlinePositionJ =
    I.Single identity "text-underline-position" << String.join " "


transform : String -> Declaration
transform =
    I.Single identity "transform"


transformJ : List String -> Declaration
transformJ =
    I.Single identity "transform" << String.join " "


transformOrigin : String -> Declaration
transformOrigin =
    I.Single identity "transform-origin"


transformOriginJ : List String -> Declaration
transformOriginJ =
    I.Single identity "transform-origin" << String.join " "


translate : String -> Declaration
translate =
    I.Single identity "translate"


translateJ : List String -> Declaration
translateJ =
    I.Single identity "translate" << String.join " "


verticalAlign : String -> Declaration
verticalAlign =
    I.Single identity "vertical-align"


verticalAlignJ : List String -> Declaration
verticalAlignJ =
    I.Single identity "vertical-align" << String.join " "


voicePitch : String -> Declaration
voicePitch =
    I.Single identity "voice-pitch"


voicePitchJ : List String -> Declaration
voicePitchJ =
    I.Single identity "voice-pitch" << String.join " "


voiceRange : String -> Declaration
voiceRange =
    I.Single identity "voice-range"


voiceRangeJ : List String -> Declaration
voiceRangeJ =
    I.Single identity "voice-range" << String.join " "


voiceRate : String -> Declaration
voiceRate =
    I.Single identity "voice-rate"


voiceRateJ : List String -> Declaration
voiceRateJ =
    I.Single identity "voice-rate" << String.join " "


voiceVolume : String -> Declaration
voiceVolume =
    I.Single identity "voice-volume"


voiceVolumeJ : List String -> Declaration
voiceVolumeJ =
    I.Single identity "voice-volume" << String.join " "


alignmentBaseline : String -> Declaration
alignmentBaseline =
    I.Single identity "alignment-baseline"


all : String -> Declaration
all =
    I.Single identity "all"


appearance : String -> Declaration
appearance =
    I.Single identity "appearance"


backfaceVisibility : String -> Declaration
backfaceVisibility =
    I.Single identity "backface-visibility"


backgroundBlendMode : String -> Declaration
backgroundBlendMode =
    I.Single identity "background-blend-mode"


backgroundColor : String -> Declaration
backgroundColor =
    I.Single identity "background-color"


baselineShift : String -> Declaration
baselineShift =
    I.Single identity "baseline-shift"


blockOverflow : String -> Declaration
blockOverflow =
    I.Single identity "block-overflow"


blockSize : String -> Declaration
blockSize =
    I.Single identity "block-size"


blockStepAlign : String -> Declaration
blockStepAlign =
    I.Single identity "block-step-align"


blockStepInsert : String -> Declaration
blockStepInsert =
    I.Single identity "block-step-insert"


blockStepRound : String -> Declaration
blockStepRound =
    I.Single identity "block-step-round"


blockStepSize : String -> Declaration
blockStepSize =
    I.Single identity "block-step-size"


bookmarkLevel : String -> Declaration
bookmarkLevel =
    I.Single identity "bookmark-level"


bookmarkState : String -> Declaration
bookmarkState =
    I.Single identity "bookmark-state"


borderBlockEndColor : String -> Declaration
borderBlockEndColor =
    I.Single identity "border-block-end-color"


borderBlockEndStyle : String -> Declaration
borderBlockEndStyle =
    I.Single identity "border-block-end-style"


borderBlockEndWidth : String -> Declaration
borderBlockEndWidth =
    I.Single identity "border-block-end-width"


borderBlockStartColor : String -> Declaration
borderBlockStartColor =
    I.Single identity "border-block-start-color"


borderBlockStartStyle : String -> Declaration
borderBlockStartStyle =
    I.Single identity "border-block-start-style"


borderBlockStartWidth : String -> Declaration
borderBlockStartWidth =
    I.Single identity "border-block-start-width"


borderBottomColor : String -> Declaration
borderBottomColor =
    I.Single identity "border-bottom-color"


borderBottomStyle : String -> Declaration
borderBottomStyle =
    I.Single identity "border-bottom-style"


borderBottomWidth : String -> Declaration
borderBottomWidth =
    I.Single identity "border-bottom-width"


borderBoundary : String -> Declaration
borderBoundary =
    I.Single identity "border-boundary"


borderCollapse : String -> Declaration
borderCollapse =
    I.Single identity "border-collapse"


borderImageSource : String -> Declaration
borderImageSource =
    I.Single identity "border-image-source"


borderInlineEndColor : String -> Declaration
borderInlineEndColor =
    I.Single identity "border-inline-end-color"


borderInlineEndStyle : String -> Declaration
borderInlineEndStyle =
    I.Single identity "border-inline-end-style"


borderInlineEndWidth : String -> Declaration
borderInlineEndWidth =
    I.Single identity "border-inline-end-width"


borderInlineStartColor : String -> Declaration
borderInlineStartColor =
    I.Single identity "border-inline-start-color"


borderInlineStartStyle : String -> Declaration
borderInlineStartStyle =
    I.Single identity "border-inline-start-style"


borderInlineStartWidth : String -> Declaration
borderInlineStartWidth =
    I.Single identity "border-inline-start-width"


borderLeftColor : String -> Declaration
borderLeftColor =
    I.Single identity "border-left-color"


borderLeftStyle : String -> Declaration
borderLeftStyle =
    I.Single identity "border-left-style"


borderLeftWidth : String -> Declaration
borderLeftWidth =
    I.Single identity "border-left-width"


borderRightColor : String -> Declaration
borderRightColor =
    I.Single identity "border-right-color"


borderRightStyle : String -> Declaration
borderRightStyle =
    I.Single identity "border-right-style"


borderRightWidth : String -> Declaration
borderRightWidth =
    I.Single identity "border-right-width"


borderTopColor : String -> Declaration
borderTopColor =
    I.Single identity "border-top-color"


borderTopStyle : String -> Declaration
borderTopStyle =
    I.Single identity "border-top-style"


borderTopWidth : String -> Declaration
borderTopWidth =
    I.Single identity "border-top-width"


bottom : String -> Declaration
bottom =
    I.Single identity "bottom"


boxDecorationBreak : String -> Declaration
boxDecorationBreak =
    I.Single identity "box-decoration-break"


boxSizing : String -> Declaration
boxSizing =
    I.Single identity "box-sizing"


boxSnap : String -> Declaration
boxSnap =
    I.Single identity "box-snap"


breakAfter : String -> Declaration
breakAfter =
    I.Single identity "break-after"


breakBefore : String -> Declaration
breakBefore =
    I.Single identity "break-before"


breakInside : String -> Declaration
breakInside =
    I.Single identity "break-inside"


captionSide : String -> Declaration
captionSide =
    I.Single identity "caption-side"


caretColor : String -> Declaration
caretColor =
    I.Single identity "caret-color"


caretShape : String -> Declaration
caretShape =
    I.Single identity "caret-shape"


clear : String -> Declaration
clear =
    I.Single identity "clear"


clip : String -> Declaration
clip =
    I.Single identity "clip"


clipRule : String -> Declaration
clipRule =
    I.Single identity "clip-rule"


color : String -> Declaration
color =
    I.Single identity "color"


colorAdjust : String -> Declaration
colorAdjust =
    I.Single identity "color-adjust"


colorInterpolationFilters : String -> Declaration
colorInterpolationFilters =
    I.Single identity "color-interpolation-filters"


columnCount : String -> Declaration
columnCount =
    I.Single identity "column-count"


columnFill : String -> Declaration
columnFill =
    I.Single identity "column-fill"


columnGap : String -> Declaration
columnGap =
    I.Single identity "column-gap"


columnRuleColor : String -> Declaration
columnRuleColor =
    I.Single identity "column-rule-color"


columnRuleStyle : String -> Declaration
columnRuleStyle =
    I.Single identity "column-rule-style"


columnRuleWidth : String -> Declaration
columnRuleWidth =
    I.Single identity "column-rule-width"


columnSpan : String -> Declaration
columnSpan =
    I.Single identity "column-span"


columnWidth : String -> Declaration
columnWidth =
    I.Single identity "column-width"


continue : String -> Declaration
continue =
    I.Single identity "continue"


direction : String -> Declaration
direction =
    I.Single identity "direction"


dominantBaseline : String -> Declaration
dominantBaseline =
    I.Single identity "dominant-baseline"


elevation : String -> Declaration
elevation =
    I.Single identity "elevation"


emptyCells : String -> Declaration
emptyCells =
    I.Single identity "empty-cells"


fillBreak : String -> Declaration
fillBreak =
    I.Single identity "fill-break"


fillColor : String -> Declaration
fillColor =
    I.Single identity "fill-color"


fillOpacity : String -> Declaration
fillOpacity =
    I.Single identity "fill-opacity"


fillOrigin : String -> Declaration
fillOrigin =
    I.Single identity "fill-origin"


fillRule : String -> Declaration
fillRule =
    I.Single identity "fill-rule"


flexBasis : String -> Declaration
flexBasis =
    I.Single identity "flex-basis"


flexDirection : String -> Declaration
flexDirection =
    I.Single identity "flex-direction"


flexWrap : String -> Declaration
flexWrap =
    I.Single identity "flex-wrap"


float : String -> Declaration
float =
    I.Single identity "float"


floatDefer : String -> Declaration
floatDefer =
    I.Single identity "float-defer"


floatOffset : String -> Declaration
floatOffset =
    I.Single identity "float-offset"


floatReference : String -> Declaration
floatReference =
    I.Single identity "float-reference"


floodColor : String -> Declaration
floodColor =
    I.Single identity "flood-color"


floodOpacity : String -> Declaration
floodOpacity =
    I.Single identity "flood-opacity"


flowFrom : String -> Declaration
flowFrom =
    I.Single identity "flow-from"


fontKerning : String -> Declaration
fontKerning =
    I.Single identity "font-kerning"


fontLanguageOverride : String -> Declaration
fontLanguageOverride =
    I.Single identity "font-language-override"


fontOpticalSizing : String -> Declaration
fontOpticalSizing =
    I.Single identity "font-optical-sizing"


fontPalette : String -> Declaration
fontPalette =
    I.Single identity "font-palette"


fontSize : String -> Declaration
fontSize =
    I.Single identity "font-size"


fontSizeAdjust : String -> Declaration
fontSizeAdjust =
    I.Single identity "font-size-adjust"


fontStretch : String -> Declaration
fontStretch =
    I.Single identity "font-stretch"


fontSynthesisSmallCaps : String -> Declaration
fontSynthesisSmallCaps =
    I.Single identity "font-synthesis-small-caps"


fontSynthesisStyle : String -> Declaration
fontSynthesisStyle =
    I.Single identity "font-synthesis-style"


fontSynthesisWeight : String -> Declaration
fontSynthesisWeight =
    I.Single identity "font-synthesis-weight"


fontVariantCaps : String -> Declaration
fontVariantCaps =
    I.Single identity "font-variant-caps"


fontVariantEmoji : String -> Declaration
fontVariantEmoji =
    I.Single identity "font-variant-emoji"


fontVariantPosition : String -> Declaration
fontVariantPosition =
    I.Single identity "font-variant-position"


fontWeight : String -> Declaration
fontWeight =
    I.Single identity "font-weight"


footnoteDisplay : String -> Declaration
footnoteDisplay =
    I.Single identity "footnote-display"


footnotePolicy : String -> Declaration
footnotePolicy =
    I.Single identity "footnote-policy"


forcedColorAdjust : String -> Declaration
forcedColorAdjust =
    I.Single identity "forced-color-adjust"


glyphOrientationVertical : String -> Declaration
glyphOrientationVertical =
    I.Single identity "glyph-orientation-vertical"


height : String -> Declaration
height =
    I.Single identity "height"


hyphenateCharacter : String -> Declaration
hyphenateCharacter =
    I.Single identity "hyphenate-character"


hyphenateLimitLast : String -> Declaration
hyphenateLimitLast =
    I.Single identity "hyphenate-limit-last"


hyphenateLimitLines : String -> Declaration
hyphenateLimitLines =
    I.Single identity "hyphenate-limit-lines"


hyphenateLimitZone : String -> Declaration
hyphenateLimitZone =
    I.Single identity "hyphenate-limit-zone"


hyphens : String -> Declaration
hyphens =
    I.Single identity "hyphens"


imageRendering : String -> Declaration
imageRendering =
    I.Single identity "image-rendering"


initialLettersWrap : String -> Declaration
initialLettersWrap =
    I.Single identity "initial-letters-wrap"


inlineSize : String -> Declaration
inlineSize =
    I.Single identity "inline-size"


inlineSizing : String -> Declaration
inlineSizing =
    I.Single identity "inline-sizing"


insetBlockEnd : String -> Declaration
insetBlockEnd =
    I.Single identity "inset-block-end"


insetBlockStart : String -> Declaration
insetBlockStart =
    I.Single identity "inset-block-start"


insetInlineEnd : String -> Declaration
insetInlineEnd =
    I.Single identity "inset-inline-end"


insetInlineStart : String -> Declaration
insetInlineStart =
    I.Single identity "inset-inline-start"


isolation : String -> Declaration
isolation =
    I.Single identity "isolation"


left : String -> Declaration
left =
    I.Single identity "left"


letterSpacing : String -> Declaration
letterSpacing =
    I.Single identity "letter-spacing"


lightingColor : String -> Declaration
lightingColor =
    I.Single identity "lighting-color"


lineBreak : String -> Declaration
lineBreak =
    I.Single identity "line-break"


lineGrid : String -> Declaration
lineGrid =
    I.Single identity "line-grid"


lineHeight : String -> Declaration
lineHeight =
    I.Single identity "line-height"


lineHeightStep : String -> Declaration
lineHeightStep =
    I.Single identity "line-height-step"


linePadding : String -> Declaration
linePadding =
    I.Single identity "line-padding"


lineSnap : String -> Declaration
lineSnap =
    I.Single identity "line-snap"


listStyleImage : String -> Declaration
listStyleImage =
    I.Single identity "list-style-image"


listStylePosition : String -> Declaration
listStylePosition =
    I.Single identity "list-style-position"


listStyleType : String -> Declaration
listStyleType =
    I.Single identity "list-style-type"


marginBlockEnd : String -> Declaration
marginBlockEnd =
    I.Single identity "margin-block-end"


marginBlockStart : String -> Declaration
marginBlockStart =
    I.Single identity "margin-block-start"


marginBottom : String -> Declaration
marginBottom =
    I.Single identity "margin-bottom"


marginBreak : String -> Declaration
marginBreak =
    I.Single identity "margin-break"


marginInlineEnd : String -> Declaration
marginInlineEnd =
    I.Single identity "margin-inline-end"


marginInlineStart : String -> Declaration
marginInlineStart =
    I.Single identity "margin-inline-start"


marginLeft : String -> Declaration
marginLeft =
    I.Single identity "margin-left"


marginRight : String -> Declaration
marginRight =
    I.Single identity "margin-right"


marginTop : String -> Declaration
marginTop =
    I.Single identity "margin-top"


marginTrim : String -> Declaration
marginTrim =
    I.Single identity "margin-trim"


markerEnd : String -> Declaration
markerEnd =
    I.Single identity "marker-end"


markerMid : String -> Declaration
markerMid =
    I.Single identity "marker-mid"


markerSegment : String -> Declaration
markerSegment =
    I.Single identity "marker-segment"


markerSide : String -> Declaration
markerSide =
    I.Single identity "marker-side"


markerStart : String -> Declaration
markerStart =
    I.Single identity "marker-start"


maskBorderMode : String -> Declaration
maskBorderMode =
    I.Single identity "mask-border-mode"


maskBorderSource : String -> Declaration
maskBorderSource =
    I.Single identity "mask-border-source"


maskType : String -> Declaration
maskType =
    I.Single identity "mask-type"


maxBlockSize : String -> Declaration
maxBlockSize =
    I.Single identity "max-block-size"


maxHeight : String -> Declaration
maxHeight =
    I.Single identity "max-height"


maxInlineSize : String -> Declaration
maxInlineSize =
    I.Single identity "max-inline-size"


maxLines : String -> Declaration
maxLines =
    I.Single identity "max-lines"


maxWidth : String -> Declaration
maxWidth =
    I.Single identity "max-width"


minBlockSize : String -> Declaration
minBlockSize =
    I.Single identity "min-block-size"


minHeight : String -> Declaration
minHeight =
    I.Single identity "min-height"


minInlineSize : String -> Declaration
minInlineSize =
    I.Single identity "min-inline-size"


minWidth : String -> Declaration
minWidth =
    I.Single identity "min-width"


mixBlendMode : String -> Declaration
mixBlendMode =
    I.Single identity "mix-blend-mode"


objectFit : String -> Declaration
objectFit =
    I.Single identity "object-fit"


offsetAfter : String -> Declaration
offsetAfter =
    I.Single identity "offset-after"


offsetBefore : String -> Declaration
offsetBefore =
    I.Single identity "offset-before"


offsetDistance : String -> Declaration
offsetDistance =
    I.Single identity "offset-distance"


offsetEnd : String -> Declaration
offsetEnd =
    I.Single identity "offset-end"


offsetRotate : String -> Declaration
offsetRotate =
    I.Single identity "offset-rotate"


offsetStart : String -> Declaration
offsetStart =
    I.Single identity "offset-start"


opacity : String -> Declaration
opacity =
    I.Single identity "opacity"


outlineColor : String -> Declaration
outlineColor =
    I.Single identity "outline-color"


outlineOffset : String -> Declaration
outlineOffset =
    I.Single identity "outline-offset"


outlineStyle : String -> Declaration
outlineStyle =
    I.Single identity "outline-style"


outlineWidth : String -> Declaration
outlineWidth =
    I.Single identity "outline-width"


overflowAnchor : String -> Declaration
overflowAnchor =
    I.Single identity "overflow-anchor"


overflowWrap : String -> Declaration
overflowWrap =
    I.Single identity "overflow-wrap"


overflowX : String -> Declaration
overflowX =
    I.Single identity "overflow-x"


overflowY : String -> Declaration
overflowY =
    I.Single identity "overflow-y"


overscrollBehaviorBlock : String -> Declaration
overscrollBehaviorBlock =
    I.Single identity "overscroll-behavior-block"


overscrollBehaviorInline : String -> Declaration
overscrollBehaviorInline =
    I.Single identity "overscroll-behavior-inline"


overscrollBehaviorX : String -> Declaration
overscrollBehaviorX =
    I.Single identity "overscroll-behavior-x"


overscrollBehaviorY : String -> Declaration
overscrollBehaviorY =
    I.Single identity "overscroll-behavior-y"


paddingBlockEnd : String -> Declaration
paddingBlockEnd =
    I.Single identity "padding-block-end"


paddingBlockStart : String -> Declaration
paddingBlockStart =
    I.Single identity "padding-block-start"


paddingBottom : String -> Declaration
paddingBottom =
    I.Single identity "padding-bottom"


paddingInlineEnd : String -> Declaration
paddingInlineEnd =
    I.Single identity "padding-inline-end"


paddingInlineStart : String -> Declaration
paddingInlineStart =
    I.Single identity "padding-inline-start"


paddingLeft : String -> Declaration
paddingLeft =
    I.Single identity "padding-left"


paddingRight : String -> Declaration
paddingRight =
    I.Single identity "padding-right"


paddingTop : String -> Declaration
paddingTop =
    I.Single identity "padding-top"


page : String -> Declaration
page =
    I.Single identity "page"


pageBreakAfter : String -> Declaration
pageBreakAfter =
    I.Single identity "page-break-after"


pageBreakBefore : String -> Declaration
pageBreakBefore =
    I.Single identity "page-break-before"


pageBreakInside : String -> Declaration
pageBreakInside =
    I.Single identity "page-break-inside"


pauseAfter : String -> Declaration
pauseAfter =
    I.Single identity "pause-after"


pauseBefore : String -> Declaration
pauseBefore =
    I.Single identity "pause-before"


perspective : String -> Declaration
perspective =
    I.Single identity "perspective"


pitch : String -> Declaration
pitch =
    I.Single identity "pitch"


pitchRange : String -> Declaration
pitchRange =
    I.Single identity "pitch-range"


pointerEvents : String -> Declaration
pointerEvents =
    I.Single identity "pointer-events"


position : String -> Declaration
position =
    I.Single identity "position"


regionFragment : String -> Declaration
regionFragment =
    I.Single identity "region-fragment"


resize : String -> Declaration
resize =
    I.Single identity "resize"


restAfter : String -> Declaration
restAfter =
    I.Single identity "rest-after"


restBefore : String -> Declaration
restBefore =
    I.Single identity "rest-before"


richness : String -> Declaration
richness =
    I.Single identity "richness"


right : String -> Declaration
right =
    I.Single identity "right"


rowGap : String -> Declaration
rowGap =
    I.Single identity "row-gap"


rubyMerge : String -> Declaration
rubyMerge =
    I.Single identity "ruby-merge"


running : String -> Declaration
running =
    I.Single identity "running"


scrollBehavior : String -> Declaration
scrollBehavior =
    I.Single identity "scroll-behavior"


scrollMarginBlockEnd : String -> Declaration
scrollMarginBlockEnd =
    I.Single identity "scroll-margin-block-end"


scrollMarginBlockStart : String -> Declaration
scrollMarginBlockStart =
    I.Single identity "scroll-margin-block-start"


scrollMarginBottom : String -> Declaration
scrollMarginBottom =
    I.Single identity "scroll-margin-bottom"


scrollMarginInlineEnd : String -> Declaration
scrollMarginInlineEnd =
    I.Single identity "scroll-margin-inline-end"


scrollMarginInlineStart : String -> Declaration
scrollMarginInlineStart =
    I.Single identity "scroll-margin-inline-start"


scrollMarginLeft : String -> Declaration
scrollMarginLeft =
    I.Single identity "scroll-margin-left"


scrollMarginRight : String -> Declaration
scrollMarginRight =
    I.Single identity "scroll-margin-right"


scrollMarginTop : String -> Declaration
scrollMarginTop =
    I.Single identity "scroll-margin-top"


scrollPaddingBlockEnd : String -> Declaration
scrollPaddingBlockEnd =
    I.Single identity "scroll-padding-block-end"


scrollPaddingBlockStart : String -> Declaration
scrollPaddingBlockStart =
    I.Single identity "scroll-padding-block-start"


scrollPaddingBottom : String -> Declaration
scrollPaddingBottom =
    I.Single identity "scroll-padding-bottom"


scrollPaddingInlineEnd : String -> Declaration
scrollPaddingInlineEnd =
    I.Single identity "scroll-padding-inline-end"


scrollPaddingInlineStart : String -> Declaration
scrollPaddingInlineStart =
    I.Single identity "scroll-padding-inline-start"


scrollPaddingLeft : String -> Declaration
scrollPaddingLeft =
    I.Single identity "scroll-padding-left"


scrollPaddingRight : String -> Declaration
scrollPaddingRight =
    I.Single identity "scroll-padding-right"


scrollPaddingTop : String -> Declaration
scrollPaddingTop =
    I.Single identity "scroll-padding-top"


scrollSnapStop : String -> Declaration
scrollSnapStop =
    I.Single identity "scroll-snap-stop"


scrollbarWidth : String -> Declaration
scrollbarWidth =
    I.Single identity "scrollbar-width"


shapeMargin : String -> Declaration
shapeMargin =
    I.Single identity "shape-margin"


spatialNavigationAction : String -> Declaration
spatialNavigationAction =
    I.Single identity "spatial-navigation-action"


spatialNavigationContain : String -> Declaration
spatialNavigationContain =
    I.Single identity "spatial-navigation-contain"


spatialNavigationFunction : String -> Declaration
spatialNavigationFunction =
    I.Single identity "spatial-navigation-function"


speak : String -> Declaration
speak =
    I.Single identity "speak"


speakHeader : String -> Declaration
speakHeader =
    I.Single identity "speak-header"


speakNumeral : String -> Declaration
speakNumeral =
    I.Single identity "speak-numeral"


speakPunctuation : String -> Declaration
speakPunctuation =
    I.Single identity "speak-punctuation"


speechRate : String -> Declaration
speechRate =
    I.Single identity "speech-rate"


stress : String -> Declaration
stress =
    I.Single identity "stress"


strokeAlign : String -> Declaration
strokeAlign =
    I.Single identity "stroke-align"


strokeAlignment : String -> Declaration
strokeAlignment =
    I.Single identity "stroke-alignment"


strokeBreak : String -> Declaration
strokeBreak =
    I.Single identity "stroke-break"


strokeDashCorner : String -> Declaration
strokeDashCorner =
    I.Single identity "stroke-dash-corner"


strokeDashcorner : String -> Declaration
strokeDashcorner =
    I.Single identity "stroke-dashcorner"


strokeDashoffset : String -> Declaration
strokeDashoffset =
    I.Single identity "stroke-dashoffset"


strokeLinecap : String -> Declaration
strokeLinecap =
    I.Single identity "stroke-linecap"


strokeOpacity : String -> Declaration
strokeOpacity =
    I.Single identity "stroke-opacity"


strokeOrigin : String -> Declaration
strokeOrigin =
    I.Single identity "stroke-origin"


tabSize : String -> Declaration
tabSize =
    I.Single identity "tab-size"


tableLayout : String -> Declaration
tableLayout =
    I.Single identity "table-layout"


textAlign : String -> Declaration
textAlign =
    I.Single identity "text-align"


textAlignAll : String -> Declaration
textAlignAll =
    I.Single identity "text-align-all"


textAlignLast : String -> Declaration
textAlignLast =
    I.Single identity "text-align-last"


textDecorationColor : String -> Declaration
textDecorationColor =
    I.Single identity "text-decoration-color"


textDecorationSkipInk : String -> Declaration
textDecorationSkipInk =
    I.Single identity "text-decoration-skip-ink"


textDecorationStyle : String -> Declaration
textDecorationStyle =
    I.Single identity "text-decoration-style"


textDecorationWidth : String -> Declaration
textDecorationWidth =
    I.Single identity "text-decoration-width"


textEmphasisColor : String -> Declaration
textEmphasisColor =
    I.Single identity "text-emphasis-color"


textGroupAlign : String -> Declaration
textGroupAlign =
    I.Single identity "text-group-align"


textJustify : String -> Declaration
textJustify =
    I.Single identity "text-justify"


textOrientation : String -> Declaration
textOrientation =
    I.Single identity "text-orientation"


textOverflow : String -> Declaration
textOverflow =
    I.Single identity "text-overflow"


textSpaceCollapse : String -> Declaration
textSpaceCollapse =
    I.Single identity "text-space-collapse"


textUnderlineOffset : String -> Declaration
textUnderlineOffset =
    I.Single identity "text-underline-offset"


textWrap : String -> Declaration
textWrap =
    I.Single identity "text-wrap"


top : String -> Declaration
top =
    I.Single identity "top"


transformBox : String -> Declaration
transformBox =
    I.Single identity "transform-box"


transformStyle : String -> Declaration
transformStyle =
    I.Single identity "transform-style"


unicodeBidi : String -> Declaration
unicodeBidi =
    I.Single identity "unicode-bidi"


userSelect : String -> Declaration
userSelect =
    I.Single identity "user-select"


visibility : String -> Declaration
visibility =
    I.Single identity "visibility"


voiceBalance : String -> Declaration
voiceBalance =
    I.Single identity "voice-balance"


voiceDuration : String -> Declaration
voiceDuration =
    I.Single identity "voice-duration"


voiceStress : String -> Declaration
voiceStress =
    I.Single identity "voice-stress"


volume : String -> Declaration
volume =
    I.Single identity "volume"


whiteSpace : String -> Declaration
whiteSpace =
    I.Single identity "white-space"


width : String -> Declaration
width =
    I.Single identity "width"


wordBoundaryDetection : String -> Declaration
wordBoundaryDetection =
    I.Single identity "word-boundary-detection"


wordBoundaryExpansion : String -> Declaration
wordBoundaryExpansion =
    I.Single identity "word-boundary-expansion"


wordBreak : String -> Declaration
wordBreak =
    I.Single identity "word-break"


wordSpacing : String -> Declaration
wordSpacing =
    I.Single identity "word-spacing"


wordWrap : String -> Declaration
wordWrap =
    I.Single identity "word-wrap"


wrapAfter : String -> Declaration
wrapAfter =
    I.Single identity "wrap-after"


wrapBefore : String -> Declaration
wrapBefore =
    I.Single identity "wrap-before"


wrapFlow : String -> Declaration
wrapFlow =
    I.Single identity "wrap-flow"


wrapInside : String -> Declaration
wrapInside =
    I.Single identity "wrap-inside"


wrapThrough : String -> Declaration
wrapThrough =
    I.Single identity "wrap-through"


writingMode : String -> Declaration
writingMode =
    I.Single identity "writing-mode"


zIndex : String -> Declaration
zIndex =
    I.Single identity "z-index"



-- Units


toUnit : String -> Float -> String
toUnit suffix n =
    String.fromFloat n ++ suffix


pct : Float -> String
pct =
    -- technically not a unit
    toUnit "%"


em : Float -> String
em =
    toUnit "em"


ex : Float -> String
ex =
    toUnit "ex"


ch : Float -> String
ch =
    toUnit "ch"


rem : Float -> String
rem =
    toUnit "rem"


vw : Float -> String
vw =
    toUnit "vw"


vh : Float -> String
vh =
    toUnit "vh"


vmin : Float -> String
vmin =
    toUnit "vmin"


vmax : Float -> String
vmax =
    toUnit "vmax"


cm : Float -> String
cm =
    toUnit "cm"


mm : Float -> String
mm =
    toUnit "mm"


q : Float -> String
q =
    toUnit "Q"


in_ : Float -> String
in_ =
    toUnit "in"


pc : Float -> String
pc =
    toUnit "pc"


pt : Float -> String
pt =
    toUnit "pt"


px : Float -> String
px =
    toUnit "px"


deg : Float -> String
deg =
    toUnit "deg"


grad : Float -> String
grad =
    toUnit "grad"


rad : Float -> String
rad =
    toUnit "rad"


turn : Float -> String
turn =
    toUnit "turn"


s : Float -> String
s =
    toUnit "s"


ms : Float -> String
ms =
    toUnit "ms"


hz : Float -> String
hz =
    toUnit "Hz"


kHz : Float -> String
kHz =
    toUnit "kHz"


dpi : Float -> String
dpi =
    toUnit "dpi"


dpcm : Float -> String
dpcm =
    toUnit "dpcm"


dppx : Float -> String
dppx =
    toUnit "dppx"


fr : Float -> String
fr =
    toUnit "fr"
