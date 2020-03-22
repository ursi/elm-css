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


createSelectorVariation : (String -> String) -> List Declaration -> Declaration
createSelectorVariation classToSelector =
    List.map
        (\declaration_ ->
            case declaration_ of
                I.Single currentClassToSelector property value ->
                    I.Single
                        (currentClassToSelector << classToSelector)
                        property
                        value

                I.Batch declarations ->
                    createSelectorVariation classToSelector declarations
        )
        >> I.Batch


append : String -> String -> String
append =
    (>>) (++) << (|>)


adjacent : List Declaration -> Declaration
adjacent =
    createSelectorVariation (\class -> class ++ " + " ++ class)


children : List Declaration -> Declaration
children =
    createSelectorVariation <| append " > *"


descendants : List Declaration -> Declaration
descendants =
    createSelectorVariation <| append " *"



-- the created style element can mess this up


firstChild : List Declaration -> Declaration
firstChild =
    createSelectorVariation <| append ":first-child"


hover : List Declaration -> Declaration
hover =
    createSelectorVariation <| append ":hover"


important : Declaration -> Declaration
important declaration_ =
    case declaration_ of
        I.Single f p value ->
            I.Single f p <| append " !important" value

        I.Batch declarations ->
            I.Batch <| List.map important declarations



-- Properties


animation : String -> Declaration
animation =
    I.Single identity "animation"


animationJ : List String -> Declaration
animationJ =
    I.Single identity "animation" << String.join ", "


animationJJ : List (List String) -> Declaration
animationJJ =
    I.Single identity "animation" << String.join ", " << List.map (String.join " ")


background : String -> Declaration
background =
    I.Single identity "background"


backgroundJ : List String -> Declaration
backgroundJ =
    I.Single identity "background" << String.join ", "


backgroundJJ : List (List String) -> Declaration
backgroundJJ =
    I.Single identity "background" << String.join ", " << List.map (String.join " ")


backgroundRepeat : String -> Declaration
backgroundRepeat =
    I.Single identity "background-repeat"


backgroundRepeatJ : List String -> Declaration
backgroundRepeatJ =
    I.Single identity "background-repeat" << String.join ", "


backgroundRepeatJJ : List (List String) -> Declaration
backgroundRepeatJJ =
    I.Single identity "background-repeat" << String.join ", " << List.map (String.join " ")


backgroundSize : String -> Declaration
backgroundSize =
    I.Single identity "background-size"


backgroundSizeJ : List String -> Declaration
backgroundSizeJ =
    I.Single identity "background-size" << String.join ", "


backgroundSizeJJ : List (List String) -> Declaration
backgroundSizeJJ =
    I.Single identity "background-size" << String.join ", " << List.map (String.join " ")


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


transform : String -> Declaration
transform =
    I.Single identity "transform"


transformJ : List String -> Declaration
transformJ =
    I.Single identity "transform" << String.join " "


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


borderBottom : String -> Declaration
borderBottom =
    I.Single identity "border-bottom"


borderBottomColor : String -> Declaration
borderBottomColor =
    I.Single identity "border-bottom-color"


borderBottomLeftRadius : String -> Declaration
borderBottomLeftRadius =
    I.Single identity "border-bottom-left-radius"


borderBottomRightRadius : String -> Declaration
borderBottomRightRadius =
    I.Single identity "border-bottom-right-radius"


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


borderColor : String -> Declaration
borderColor =
    I.Single identity "border-color"


borderEndEndRadius : String -> Declaration
borderEndEndRadius =
    I.Single identity "border-end-end-radius"


borderEndStartRadius : String -> Declaration
borderEndStartRadius =
    I.Single identity "border-end-start-radius"


borderImage : String -> Declaration
borderImage =
    I.Single identity "border-image"


borderImageOutset : String -> Declaration
borderImageOutset =
    I.Single identity "border-image-outset"


borderImageRepeat : String -> Declaration
borderImageRepeat =
    I.Single identity "border-image-repeat"


borderImageSlice : String -> Declaration
borderImageSlice =
    I.Single identity "border-image-slice"


borderImageSource : String -> Declaration
borderImageSource =
    I.Single identity "border-image-source"


borderImageWidth : String -> Declaration
borderImageWidth =
    I.Single identity "border-image-width"


borderInline : String -> Declaration
borderInline =
    I.Single identity "border-inline"


borderInlineColor : String -> Declaration
borderInlineColor =
    I.Single identity "border-inline-color"


borderInlineEnd : String -> Declaration
borderInlineEnd =
    I.Single identity "border-inline-end"


borderInlineEndColor : String -> Declaration
borderInlineEndColor =
    I.Single identity "border-inline-end-color"


borderInlineEndStyle : String -> Declaration
borderInlineEndStyle =
    I.Single identity "border-inline-end-style"


borderInlineEndWidth : String -> Declaration
borderInlineEndWidth =
    I.Single identity "border-inline-end-width"


borderInlineStart : String -> Declaration
borderInlineStart =
    I.Single identity "border-inline-start"


borderInlineStartColor : String -> Declaration
borderInlineStartColor =
    I.Single identity "border-inline-start-color"


borderInlineStartStyle : String -> Declaration
borderInlineStartStyle =
    I.Single identity "border-inline-start-style"


borderInlineStartWidth : String -> Declaration
borderInlineStartWidth =
    I.Single identity "border-inline-start-width"


borderInlineStyle : String -> Declaration
borderInlineStyle =
    I.Single identity "border-inline-style"


borderInlineWidth : String -> Declaration
borderInlineWidth =
    I.Single identity "border-inline-width"


borderLeft : String -> Declaration
borderLeft =
    I.Single identity "border-left"


borderLeftColor : String -> Declaration
borderLeftColor =
    I.Single identity "border-left-color"


borderLeftStyle : String -> Declaration
borderLeftStyle =
    I.Single identity "border-left-style"


borderLeftWidth : String -> Declaration
borderLeftWidth =
    I.Single identity "border-left-width"


borderRadius : String -> Declaration
borderRadius =
    I.Single identity "border-radius"


borderRight : String -> Declaration
borderRight =
    I.Single identity "border-right"


borderRightColor : String -> Declaration
borderRightColor =
    I.Single identity "border-right-color"


borderRightStyle : String -> Declaration
borderRightStyle =
    I.Single identity "border-right-style"


borderRightWidth : String -> Declaration
borderRightWidth =
    I.Single identity "border-right-width"


borderSpacing : String -> Declaration
borderSpacing =
    I.Single identity "border-spacing"


borderStartEndRadius : String -> Declaration
borderStartEndRadius =
    I.Single identity "border-start-end-radius"


borderStartStartRadius : String -> Declaration
borderStartStartRadius =
    I.Single identity "border-start-start-radius"


borderStyle : String -> Declaration
borderStyle =
    I.Single identity "border-style"


borderTop : String -> Declaration
borderTop =
    I.Single identity "border-top"


borderTopColor : String -> Declaration
borderTopColor =
    I.Single identity "border-top-color"


borderTopLeftRadius : String -> Declaration
borderTopLeftRadius =
    I.Single identity "border-top-left-radius"


borderTopRightRadius : String -> Declaration
borderTopRightRadius =
    I.Single identity "border-top-right-radius"


borderTopStyle : String -> Declaration
borderTopStyle =
    I.Single identity "border-top-style"


borderTopWidth : String -> Declaration
borderTopWidth =
    I.Single identity "border-top-width"


borderWidth : String -> Declaration
borderWidth =
    I.Single identity "border-width"


bottom : String -> Declaration
bottom =
    I.Single identity "bottom"


boxDecorationBreak : String -> Declaration
boxDecorationBreak =
    I.Single identity "box-decoration-break"


boxShadow : String -> Declaration
boxShadow =
    I.Single identity "box-shadow"


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


caret : String -> Declaration
caret =
    I.Single identity "caret"


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


clipPath : String -> Declaration
clipPath =
    I.Single identity "clip-path"


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


colorScheme : String -> Declaration
colorScheme =
    I.Single identity "color-scheme"


columnCount : String -> Declaration
columnCount =
    I.Single identity "column-count"


columnFill : String -> Declaration
columnFill =
    I.Single identity "column-fill"


columnGap : String -> Declaration
columnGap =
    I.Single identity "column-gap"


columnRule : String -> Declaration
columnRule =
    I.Single identity "column-rule"


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


columns : String -> Declaration
columns =
    I.Single identity "columns"


contain : String -> Declaration
contain =
    I.Single identity "contain"


content : String -> Declaration
content =
    I.Single identity "content"


continue : String -> Declaration
continue =
    I.Single identity "continue"


counterIncrement : String -> Declaration
counterIncrement =
    I.Single identity "counter-increment"


counterReset : String -> Declaration
counterReset =
    I.Single identity "counter-reset"


counterSet : String -> Declaration
counterSet =
    I.Single identity "counter-set"


cue : String -> Declaration
cue =
    I.Single identity "cue"


cueAfter : String -> Declaration
cueAfter =
    I.Single identity "cue-after"


cueBefore : String -> Declaration
cueBefore =
    I.Single identity "cue-before"


cursor : String -> Declaration
cursor =
    I.Single identity "cursor"


direction : String -> Declaration
direction =
    I.Single identity "direction"


display : String -> Declaration
display =
    I.Single identity "display"


dominantBaseline : String -> Declaration
dominantBaseline =
    I.Single identity "dominant-baseline"


elevation : String -> Declaration
elevation =
    I.Single identity "elevation"


emptyCells : String -> Declaration
emptyCells =
    I.Single identity "empty-cells"


fill : String -> Declaration
fill =
    I.Single identity "fill"


fillBreak : String -> Declaration
fillBreak =
    I.Single identity "fill-break"


fillColor : String -> Declaration
fillColor =
    I.Single identity "fill-color"


fillImage : String -> Declaration
fillImage =
    I.Single identity "fill-image"


fillOpacity : String -> Declaration
fillOpacity =
    I.Single identity "fill-opacity"


fillOrigin : String -> Declaration
fillOrigin =
    I.Single identity "fill-origin"


fillPosition : String -> Declaration
fillPosition =
    I.Single identity "fill-position"


fillRepeat : String -> Declaration
fillRepeat =
    I.Single identity "fill-repeat"


fillRule : String -> Declaration
fillRule =
    I.Single identity "fill-rule"


fillSize : String -> Declaration
fillSize =
    I.Single identity "fill-size"


filter : String -> Declaration
filter =
    I.Single identity "filter"


flex : String -> Declaration
flex =
    I.Single identity "flex"


flexBasis : String -> Declaration
flexBasis =
    I.Single identity "flex-basis"


flexDirection : String -> Declaration
flexDirection =
    I.Single identity "flex-direction"


flexFlow : String -> Declaration
flexFlow =
    I.Single identity "flex-flow"


flexGrow : String -> Declaration
flexGrow =
    I.Single identity "flex-grow"


flexShrink : String -> Declaration
flexShrink =
    I.Single identity "flex-shrink"


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


flowInto : String -> Declaration
flowInto =
    I.Single identity "flow-into"


font : String -> Declaration
font =
    I.Single identity "font"


fontFamily : String -> Declaration
fontFamily =
    I.Single identity "font-family"


fontFeatureSettings : String -> Declaration
fontFeatureSettings =
    I.Single identity "font-feature-settings"


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


fontStyle : String -> Declaration
fontStyle =
    I.Single identity "font-style"


fontSynthesis : String -> Declaration
fontSynthesis =
    I.Single identity "font-synthesis"


fontSynthesisSmallCaps : String -> Declaration
fontSynthesisSmallCaps =
    I.Single identity "font-synthesis-small-caps"


fontSynthesisStyle : String -> Declaration
fontSynthesisStyle =
    I.Single identity "font-synthesis-style"


fontSynthesisWeight : String -> Declaration
fontSynthesisWeight =
    I.Single identity "font-synthesis-weight"


fontVariant : String -> Declaration
fontVariant =
    I.Single identity "font-variant"


fontVariantAlternates : String -> Declaration
fontVariantAlternates =
    I.Single identity "font-variant-alternates"


fontVariantCaps : String -> Declaration
fontVariantCaps =
    I.Single identity "font-variant-caps"


fontVariantEastAsian : String -> Declaration
fontVariantEastAsian =
    I.Single identity "font-variant-east-asian"


fontVariantEmoji : String -> Declaration
fontVariantEmoji =
    I.Single identity "font-variant-emoji"


fontVariantLigatures : String -> Declaration
fontVariantLigatures =
    I.Single identity "font-variant-ligatures"


fontVariantNumeric : String -> Declaration
fontVariantNumeric =
    I.Single identity "font-variant-numeric"


fontVariantPosition : String -> Declaration
fontVariantPosition =
    I.Single identity "font-variant-position"


fontVariationSettings : String -> Declaration
fontVariationSettings =
    I.Single identity "font-variation-settings"


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


gap : String -> Declaration
gap =
    I.Single identity "gap"


glyphOrientationVertical : String -> Declaration
glyphOrientationVertical =
    I.Single identity "glyph-orientation-vertical"


grid : String -> Declaration
grid =
    I.Single identity "grid"


gridArea : String -> Declaration
gridArea =
    I.Single identity "grid-area"


gridAutoColumns : String -> Declaration
gridAutoColumns =
    I.Single identity "grid-auto-columns"


gridAutoFlow : String -> Declaration
gridAutoFlow =
    I.Single identity "grid-auto-flow"


gridAutoRows : String -> Declaration
gridAutoRows =
    I.Single identity "grid-auto-rows"


gridColumn : String -> Declaration
gridColumn =
    I.Single identity "grid-column"


gridColumnEnd : String -> Declaration
gridColumnEnd =
    I.Single identity "grid-column-end"


gridColumnStart : String -> Declaration
gridColumnStart =
    I.Single identity "grid-column-start"


gridRow : String -> Declaration
gridRow =
    I.Single identity "grid-row"


gridRowEnd : String -> Declaration
gridRowEnd =
    I.Single identity "grid-row-end"


gridRowStart : String -> Declaration
gridRowStart =
    I.Single identity "grid-row-start"


gridTemplate : String -> Declaration
gridTemplate =
    I.Single identity "grid-template"


gridTemplateAreas : String -> Declaration
gridTemplateAreas =
    I.Single identity "grid-template-areas"


gridTemplateColumns : String -> Declaration
gridTemplateColumns =
    I.Single identity "grid-template-columns"


gridTemplateRows : String -> Declaration
gridTemplateRows =
    I.Single identity "grid-template-rows"


hangingPunctuation : String -> Declaration
hangingPunctuation =
    I.Single identity "hanging-punctuation"


height : String -> Declaration
height =
    I.Single identity "height"


hyphenateCharacter : String -> Declaration
hyphenateCharacter =
    I.Single identity "hyphenate-character"


hyphenateLimitChars : String -> Declaration
hyphenateLimitChars =
    I.Single identity "hyphenate-limit-chars"


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


imageOrientation : String -> Declaration
imageOrientation =
    I.Single identity "image-orientation"


imageRendering : String -> Declaration
imageRendering =
    I.Single identity "image-rendering"


imageResolution : String -> Declaration
imageResolution =
    I.Single identity "image-resolution"


initialLetters : String -> Declaration
initialLetters =
    I.Single identity "initial-letters"


initialLettersAlign : String -> Declaration
initialLettersAlign =
    I.Single identity "initial-letters-align"


initialLettersWrap : String -> Declaration
initialLettersWrap =
    I.Single identity "initial-letters-wrap"


inlineSize : String -> Declaration
inlineSize =
    I.Single identity "inline-size"


inlineSizing : String -> Declaration
inlineSizing =
    I.Single identity "inline-sizing"


inset : String -> Declaration
inset =
    I.Single identity "inset"


insetBlock : String -> Declaration
insetBlock =
    I.Single identity "inset-block"


insetBlockEnd : String -> Declaration
insetBlockEnd =
    I.Single identity "inset-block-end"


insetBlockStart : String -> Declaration
insetBlockStart =
    I.Single identity "inset-block-start"


insetInline : String -> Declaration
insetInline =
    I.Single identity "inset-inline"


insetInlineEnd : String -> Declaration
insetInlineEnd =
    I.Single identity "inset-inline-end"


insetInlineStart : String -> Declaration
insetInlineStart =
    I.Single identity "inset-inline-start"


isolation : String -> Declaration
isolation =
    I.Single identity "isolation"


justifyContent : String -> Declaration
justifyContent =
    I.Single identity "justify-content"


justifyItems : String -> Declaration
justifyItems =
    I.Single identity "justify-items"


justifySelf : String -> Declaration
justifySelf =
    I.Single identity "justify-self"


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


lineClamp : String -> Declaration
lineClamp =
    I.Single identity "line-clamp"


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


listStyle : String -> Declaration
listStyle =
    I.Single identity "list-style"


listStyleImage : String -> Declaration
listStyleImage =
    I.Single identity "list-style-image"


listStylePosition : String -> Declaration
listStylePosition =
    I.Single identity "list-style-position"


listStyleType : String -> Declaration
listStyleType =
    I.Single identity "list-style-type"


margin : String -> Declaration
margin =
    I.Single identity "margin"


marginBlock : String -> Declaration
marginBlock =
    I.Single identity "margin-block"


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


marginInline : String -> Declaration
marginInline =
    I.Single identity "margin-inline"


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


marker : String -> Declaration
marker =
    I.Single identity "marker"


markerEnd : String -> Declaration
markerEnd =
    I.Single identity "marker-end"


markerKnockoutLeft : String -> Declaration
markerKnockoutLeft =
    I.Single identity "marker-knockout-left"


markerKnockoutRight : String -> Declaration
markerKnockoutRight =
    I.Single identity "marker-knockout-right"


markerMid : String -> Declaration
markerMid =
    I.Single identity "marker-mid"


markerPattern : String -> Declaration
markerPattern =
    I.Single identity "marker-pattern"


markerSegment : String -> Declaration
markerSegment =
    I.Single identity "marker-segment"


markerSide : String -> Declaration
markerSide =
    I.Single identity "marker-side"


markerStart : String -> Declaration
markerStart =
    I.Single identity "marker-start"


mask : String -> Declaration
mask =
    I.Single identity "mask"


maskBorder : String -> Declaration
maskBorder =
    I.Single identity "mask-border"


maskBorderMode : String -> Declaration
maskBorderMode =
    I.Single identity "mask-border-mode"


maskBorderOutset : String -> Declaration
maskBorderOutset =
    I.Single identity "mask-border-outset"


maskBorderRepeat : String -> Declaration
maskBorderRepeat =
    I.Single identity "mask-border-repeat"


maskBorderSlice : String -> Declaration
maskBorderSlice =
    I.Single identity "mask-border-slice"


maskBorderSource : String -> Declaration
maskBorderSource =
    I.Single identity "mask-border-source"


maskBorderWidth : String -> Declaration
maskBorderWidth =
    I.Single identity "mask-border-width"


maskClip : String -> Declaration
maskClip =
    I.Single identity "mask-clip"


maskComposite : String -> Declaration
maskComposite =
    I.Single identity "mask-composite"


maskImage : String -> Declaration
maskImage =
    I.Single identity "mask-image"


maskMode : String -> Declaration
maskMode =
    I.Single identity "mask-mode"


maskOrigin : String -> Declaration
maskOrigin =
    I.Single identity "mask-origin"


maskPosition : String -> Declaration
maskPosition =
    I.Single identity "mask-position"


maskRepeat : String -> Declaration
maskRepeat =
    I.Single identity "mask-repeat"


maskSize : String -> Declaration
maskSize =
    I.Single identity "mask-size"


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


navDown : String -> Declaration
navDown =
    I.Single identity "nav-down"


navLeft : String -> Declaration
navLeft =
    I.Single identity "nav-left"


navRight : String -> Declaration
navRight =
    I.Single identity "nav-right"


navUp : String -> Declaration
navUp =
    I.Single identity "nav-up"


objectFit : String -> Declaration
objectFit =
    I.Single identity "object-fit"


objectPosition : String -> Declaration
objectPosition =
    I.Single identity "object-position"


offset : String -> Declaration
offset =
    I.Single identity "offset"


offsetAfter : String -> Declaration
offsetAfter =
    I.Single identity "offset-after"


offsetAnchor : String -> Declaration
offsetAnchor =
    I.Single identity "offset-anchor"


offsetBefore : String -> Declaration
offsetBefore =
    I.Single identity "offset-before"


offsetDistance : String -> Declaration
offsetDistance =
    I.Single identity "offset-distance"


offsetEnd : String -> Declaration
offsetEnd =
    I.Single identity "offset-end"


offsetPath : String -> Declaration
offsetPath =
    I.Single identity "offset-path"


offsetPosition : String -> Declaration
offsetPosition =
    I.Single identity "offset-position"


offsetRotate : String -> Declaration
offsetRotate =
    I.Single identity "offset-rotate"


offsetStart : String -> Declaration
offsetStart =
    I.Single identity "offset-start"


opacity : String -> Declaration
opacity =
    I.Single identity "opacity"


order : String -> Declaration
order =
    I.Single identity "order"


orphans : String -> Declaration
orphans =
    I.Single identity "orphans"


outline : String -> Declaration
outline =
    I.Single identity "outline"


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


overflow : String -> Declaration
overflow =
    I.Single identity "overflow"


overflowAnchor : String -> Declaration
overflowAnchor =
    I.Single identity "overflow-anchor"


overflowBlock : String -> Declaration
overflowBlock =
    I.Single identity "overflow-block"


overflowInline : String -> Declaration
overflowInline =
    I.Single identity "overflow-inline"


overflowWrap : String -> Declaration
overflowWrap =
    I.Single identity "overflow-wrap"


overflowX : String -> Declaration
overflowX =
    I.Single identity "overflow-x"


overflowY : String -> Declaration
overflowY =
    I.Single identity "overflow-y"


overscrollBehavior : String -> Declaration
overscrollBehavior =
    I.Single identity "overscroll-behavior"


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


padding : String -> Declaration
padding =
    I.Single identity "padding"


paddingBlock : String -> Declaration
paddingBlock =
    I.Single identity "padding-block"


paddingBlockEnd : String -> Declaration
paddingBlockEnd =
    I.Single identity "padding-block-end"


paddingBlockStart : String -> Declaration
paddingBlockStart =
    I.Single identity "padding-block-start"


paddingBottom : String -> Declaration
paddingBottom =
    I.Single identity "padding-bottom"


paddingInline : String -> Declaration
paddingInline =
    I.Single identity "padding-inline"


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


pause : String -> Declaration
pause =
    I.Single identity "pause"


pauseAfter : String -> Declaration
pauseAfter =
    I.Single identity "pause-after"


pauseBefore : String -> Declaration
pauseBefore =
    I.Single identity "pause-before"


perspective : String -> Declaration
perspective =
    I.Single identity "perspective"


perspectiveOrigin : String -> Declaration
perspectiveOrigin =
    I.Single identity "perspective-origin"


pitch : String -> Declaration
pitch =
    I.Single identity "pitch"


pitchRange : String -> Declaration
pitchRange =
    I.Single identity "pitch-range"


placeContent : String -> Declaration
placeContent =
    I.Single identity "place-content"


placeItems : String -> Declaration
placeItems =
    I.Single identity "place-items"


placeSelf : String -> Declaration
placeSelf =
    I.Single identity "place-self"


playDuring : String -> Declaration
playDuring =
    I.Single identity "play-during"


pointerEvents : String -> Declaration
pointerEvents =
    I.Single identity "pointer-events"


position : String -> Declaration
position =
    I.Single identity "position"


quotes : String -> Declaration
quotes =
    I.Single identity "quotes"


regionFragment : String -> Declaration
regionFragment =
    I.Single identity "region-fragment"


resize : String -> Declaration
resize =
    I.Single identity "resize"


rest : String -> Declaration
rest =
    I.Single identity "rest"


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


rotate : String -> Declaration
rotate =
    I.Single identity "rotate"


rowGap : String -> Declaration
rowGap =
    I.Single identity "row-gap"


rubyAlign : String -> Declaration
rubyAlign =
    I.Single identity "ruby-align"


rubyMerge : String -> Declaration
rubyMerge =
    I.Single identity "ruby-merge"


rubyPosition : String -> Declaration
rubyPosition =
    I.Single identity "ruby-position"


running : String -> Declaration
running =
    I.Single identity "running"


scale : String -> Declaration
scale =
    I.Single identity "scale"


scrollBehavior : String -> Declaration
scrollBehavior =
    I.Single identity "scroll-behavior"


scrollMargin : String -> Declaration
scrollMargin =
    I.Single identity "scroll-margin"


scrollMarginBlock : String -> Declaration
scrollMarginBlock =
    I.Single identity "scroll-margin-block"


scrollMarginBlockEnd : String -> Declaration
scrollMarginBlockEnd =
    I.Single identity "scroll-margin-block-end"


scrollMarginBlockStart : String -> Declaration
scrollMarginBlockStart =
    I.Single identity "scroll-margin-block-start"


scrollMarginBottom : String -> Declaration
scrollMarginBottom =
    I.Single identity "scroll-margin-bottom"


scrollMarginInline : String -> Declaration
scrollMarginInline =
    I.Single identity "scroll-margin-inline"


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


scrollPadding : String -> Declaration
scrollPadding =
    I.Single identity "scroll-padding"


scrollPaddingBlock : String -> Declaration
scrollPaddingBlock =
    I.Single identity "scroll-padding-block"


scrollPaddingBlockEnd : String -> Declaration
scrollPaddingBlockEnd =
    I.Single identity "scroll-padding-block-end"


scrollPaddingBlockStart : String -> Declaration
scrollPaddingBlockStart =
    I.Single identity "scroll-padding-block-start"


scrollPaddingBottom : String -> Declaration
scrollPaddingBottom =
    I.Single identity "scroll-padding-bottom"


scrollPaddingInline : String -> Declaration
scrollPaddingInline =
    I.Single identity "scroll-padding-inline"


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


scrollSnapAlign : String -> Declaration
scrollSnapAlign =
    I.Single identity "scroll-snap-align"


scrollSnapStop : String -> Declaration
scrollSnapStop =
    I.Single identity "scroll-snap-stop"


scrollSnapType : String -> Declaration
scrollSnapType =
    I.Single identity "scroll-snap-type"


scrollbarColor : String -> Declaration
scrollbarColor =
    I.Single identity "scrollbar-color"


scrollbarGutter : String -> Declaration
scrollbarGutter =
    I.Single identity "scrollbar-gutter"


scrollbarWidth : String -> Declaration
scrollbarWidth =
    I.Single identity "scrollbar-width"


shapeImageThreshold : String -> Declaration
shapeImageThreshold =
    I.Single identity "shape-image-threshold"


shapeInside : String -> Declaration
shapeInside =
    I.Single identity "shape-inside"


shapeMargin : String -> Declaration
shapeMargin =
    I.Single identity "shape-margin"


shapeOutside : String -> Declaration
shapeOutside =
    I.Single identity "shape-outside"


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


speakAs : String -> Declaration
speakAs =
    I.Single identity "speak-as"


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


stringSet : String -> Declaration
stringSet =
    I.Single identity "string-set"


stroke : String -> Declaration
stroke =
    I.Single identity "stroke"


strokeAlign : String -> Declaration
strokeAlign =
    I.Single identity "stroke-align"


strokeAlignment : String -> Declaration
strokeAlignment =
    I.Single identity "stroke-alignment"


strokeBreak : String -> Declaration
strokeBreak =
    I.Single identity "stroke-break"


strokeColor : String -> Declaration
strokeColor =
    I.Single identity "stroke-color"


strokeDashCorner : String -> Declaration
strokeDashCorner =
    I.Single identity "stroke-dash-corner"


strokeDashJustify : String -> Declaration
strokeDashJustify =
    I.Single identity "stroke-dash-justify"


strokeDashadjust : String -> Declaration
strokeDashadjust =
    I.Single identity "stroke-dashadjust"


strokeDasharray : String -> Declaration
strokeDasharray =
    I.Single identity "stroke-dasharray"


strokeDashcorner : String -> Declaration
strokeDashcorner =
    I.Single identity "stroke-dashcorner"


strokeDashoffset : String -> Declaration
strokeDashoffset =
    I.Single identity "stroke-dashoffset"


strokeImage : String -> Declaration
strokeImage =
    I.Single identity "stroke-image"


strokeLinecap : String -> Declaration
strokeLinecap =
    I.Single identity "stroke-linecap"


strokeLinejoin : String -> Declaration
strokeLinejoin =
    I.Single identity "stroke-linejoin"


strokeMiterlimit : String -> Declaration
strokeMiterlimit =
    I.Single identity "stroke-miterlimit"


strokeOpacity : String -> Declaration
strokeOpacity =
    I.Single identity "stroke-opacity"


strokeOrigin : String -> Declaration
strokeOrigin =
    I.Single identity "stroke-origin"


strokePosition : String -> Declaration
strokePosition =
    I.Single identity "stroke-position"


strokeRepeat : String -> Declaration
strokeRepeat =
    I.Single identity "stroke-repeat"


strokeSize : String -> Declaration
strokeSize =
    I.Single identity "stroke-size"


strokeWidth : String -> Declaration
strokeWidth =
    I.Single identity "stroke-width"


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


textCombineUpright : String -> Declaration
textCombineUpright =
    I.Single identity "text-combine-upright"


textDecoration : String -> Declaration
textDecoration =
    I.Single identity "text-decoration"


textDecorationColor : String -> Declaration
textDecorationColor =
    I.Single identity "text-decoration-color"


textDecorationLine : String -> Declaration
textDecorationLine =
    I.Single identity "text-decoration-line"


textDecorationSkip : String -> Declaration
textDecorationSkip =
    I.Single identity "text-decoration-skip"


textDecorationSkipInk : String -> Declaration
textDecorationSkipInk =
    I.Single identity "text-decoration-skip-ink"


textDecorationStyle : String -> Declaration
textDecorationStyle =
    I.Single identity "text-decoration-style"


textDecorationWidth : String -> Declaration
textDecorationWidth =
    I.Single identity "text-decoration-width"


textEmphasis : String -> Declaration
textEmphasis =
    I.Single identity "text-emphasis"


textEmphasisColor : String -> Declaration
textEmphasisColor =
    I.Single identity "text-emphasis-color"


textEmphasisPosition : String -> Declaration
textEmphasisPosition =
    I.Single identity "text-emphasis-position"


textEmphasisSkip : String -> Declaration
textEmphasisSkip =
    I.Single identity "text-emphasis-skip"


textEmphasisStyle : String -> Declaration
textEmphasisStyle =
    I.Single identity "text-emphasis-style"


textGroupAlign : String -> Declaration
textGroupAlign =
    I.Single identity "text-group-align"


textIndent : String -> Declaration
textIndent =
    I.Single identity "text-indent"


textJustify : String -> Declaration
textJustify =
    I.Single identity "text-justify"


textOrientation : String -> Declaration
textOrientation =
    I.Single identity "text-orientation"


textOverflow : String -> Declaration
textOverflow =
    I.Single identity "text-overflow"


textShadow : String -> Declaration
textShadow =
    I.Single identity "text-shadow"


textSpaceCollapse : String -> Declaration
textSpaceCollapse =
    I.Single identity "text-space-collapse"


textSpaceTrim : String -> Declaration
textSpaceTrim =
    I.Single identity "text-space-trim"


textSpacing : String -> Declaration
textSpacing =
    I.Single identity "text-spacing"


textTransform : String -> Declaration
textTransform =
    I.Single identity "text-transform"


textUnderlineOffset : String -> Declaration
textUnderlineOffset =
    I.Single identity "text-underline-offset"


textUnderlinePosition : String -> Declaration
textUnderlinePosition =
    I.Single identity "text-underline-position"


textWrap : String -> Declaration
textWrap =
    I.Single identity "text-wrap"


top : String -> Declaration
top =
    I.Single identity "top"


transformBox : String -> Declaration
transformBox =
    I.Single identity "transform-box"


transformOrigin : String -> Declaration
transformOrigin =
    I.Single identity "transform-origin"


transformStyle : String -> Declaration
transformStyle =
    I.Single identity "transform-style"


transition : String -> Declaration
transition =
    I.Single identity "transition"


transitionDelay : String -> Declaration
transitionDelay =
    I.Single identity "transition-delay"


transitionDuration : String -> Declaration
transitionDuration =
    I.Single identity "transition-duration"


transitionProperty : String -> Declaration
transitionProperty =
    I.Single identity "transition-property"


transitionTimingFunction : String -> Declaration
transitionTimingFunction =
    I.Single identity "transition-timing-function"


translate : String -> Declaration
translate =
    I.Single identity "translate"


unicodeBidi : String -> Declaration
unicodeBidi =
    I.Single identity "unicode-bidi"


userSelect : String -> Declaration
userSelect =
    I.Single identity "user-select"


verticalAlign : String -> Declaration
verticalAlign =
    I.Single identity "vertical-align"


visibility : String -> Declaration
visibility =
    I.Single identity "visibility"


voiceBalance : String -> Declaration
voiceBalance =
    I.Single identity "voice-balance"


voiceDuration : String -> Declaration
voiceDuration =
    I.Single identity "voice-duration"


voiceFamily : String -> Declaration
voiceFamily =
    I.Single identity "voice-family"


voicePitch : String -> Declaration
voicePitch =
    I.Single identity "voice-pitch"


voiceRange : String -> Declaration
voiceRange =
    I.Single identity "voice-range"


voiceRate : String -> Declaration
voiceRate =
    I.Single identity "voice-rate"


voiceStress : String -> Declaration
voiceStress =
    I.Single identity "voice-stress"


voiceVolume : String -> Declaration
voiceVolume =
    I.Single identity "voice-volume"


volume : String -> Declaration
volume =
    I.Single identity "volume"


whiteSpace : String -> Declaration
whiteSpace =
    I.Single identity "white-space"


widows : String -> Declaration
widows =
    I.Single identity "widows"


width : String -> Declaration
width =
    I.Single identity "width"


willChange : String -> Declaration
willChange =
    I.Single identity "will-change"


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



-- Functions


function : String -> String -> String
function name a =
    name ++ "(" ++ a ++ ")"


function2 : String -> String -> String -> String
function2 name a b =
    name ++ "(" ++ a ++ ", " ++ b ++ ")"


function3 : String -> String -> String -> String -> String
function3 name a b c =
    name ++ "(" ++ a ++ ", " ++ b ++ ", " ++ c ++ ")"


function4 : String -> String -> String -> String -> String -> String
function4 name a b c d =
    name ++ "(" ++ a ++ ", " ++ b ++ ", " ++ c ++ ", " ++ d ++ ")"


functionJ : String -> List String -> String
functionJ name args =
    name ++ "(" ++ String.join ", " args ++ ")"


matrix : String -> String
matrix =
    function "matrix"


translate_ : String -> String
translate_ =
    function "translate"


translateX : String -> String
translateX =
    function "translateX"


translateY : String -> String
translateY =
    function "translateY"


scale_ : String -> String
scale_ =
    function "scale"


scaleX : String -> String
scaleX =
    function "scaleX"


scaleY : String -> String
scaleY =
    function "scaleY"


rotate_ : String -> String
rotate_ =
    function "rotate"


skew : String -> String
skew =
    function "skew"


skewX : String -> String
skewX =
    function "skewX"


skewY : String -> String
skewY =
    function "skewY"


rgb : String -> String -> String -> String
rgb =
    function3 "rgb"


rgba : String -> String -> String -> String -> String
rgba =
    function4 "rgba"


hls : String -> String -> String -> String
hls =
    function3 "hls"


hlsa : String -> String -> String -> String -> String
hlsa =
    function4 "hlsa"


url : String -> String
url url_ =
    "url('" ++ url_ ++ "')"



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
