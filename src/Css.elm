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


important : String -> String
important =
    append " !important"


importantJ : List String -> String
importantJ =
    append " !important" << String.join " "



-- Properties
-- https://ellie-app.com/8mDhdJMyRq4a1


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


alignmentBaseline : String -> Declaration
alignmentBaseline =
    I.Single identity "alignment-baseline"


alignmentBaselineJ : List String -> Declaration
alignmentBaselineJ =
    I.Single identity "alignment-baseline" << String.join " "


all : String -> Declaration
all =
    I.Single identity "all"


animation : String -> Declaration
animation =
    I.Single identity "animation"


animationJ : List String -> Declaration
animationJ =
    I.Single identity "animation" << String.join " "


animationDelay : String -> Declaration
animationDelay =
    I.Single identity "animation-delay"


animationDelayJ : List String -> Declaration
animationDelayJ =
    I.Single identity "animation-delay" << String.join " "


animationDirection : String -> Declaration
animationDirection =
    I.Single identity "animation-direction"


animationDirectionJ : List String -> Declaration
animationDirectionJ =
    I.Single identity "animation-direction" << String.join " "


animationDuration : String -> Declaration
animationDuration =
    I.Single identity "animation-duration"


animationDurationJ : List String -> Declaration
animationDurationJ =
    I.Single identity "animation-duration" << String.join " "


animationFillMode : String -> Declaration
animationFillMode =
    I.Single identity "animation-fill-mode"


animationFillModeJ : List String -> Declaration
animationFillModeJ =
    I.Single identity "animation-fill-mode" << String.join " "


animationIterationCount : String -> Declaration
animationIterationCount =
    I.Single identity "animation-iteration-count"


animationIterationCountJ : List String -> Declaration
animationIterationCountJ =
    I.Single identity "animation-iteration-count" << String.join " "


animationName : String -> Declaration
animationName =
    I.Single identity "animation-name"


animationNameJ : List String -> Declaration
animationNameJ =
    I.Single identity "animation-name" << String.join " "


animationPlayState : String -> Declaration
animationPlayState =
    I.Single identity "animation-play-state"


animationPlayStateJ : List String -> Declaration
animationPlayStateJ =
    I.Single identity "animation-play-state" << String.join " "


animationTimingFunction : String -> Declaration
animationTimingFunction =
    I.Single identity "animation-timing-function"


animationTimingFunctionJ : List String -> Declaration
animationTimingFunctionJ =
    I.Single identity "animation-timing-function" << String.join " "


appearance : String -> Declaration
appearance =
    I.Single identity "appearance"


appearanceJ : List String -> Declaration
appearanceJ =
    I.Single identity "appearance" << String.join " "


azimuth : String -> Declaration
azimuth =
    I.Single identity "azimuth"


azimuthJ : List String -> Declaration
azimuthJ =
    I.Single identity "azimuth" << String.join " "


backfaceVisibility : String -> Declaration
backfaceVisibility =
    I.Single identity "backface-visibility"


backfaceVisibilityJ : List String -> Declaration
backfaceVisibilityJ =
    I.Single identity "backface-visibility" << String.join " "


background : String -> Declaration
background =
    I.Single identity "background"


backgroundJ : List String -> Declaration
backgroundJ =
    I.Single identity "background" << String.join " "


backgroundAttachment : String -> Declaration
backgroundAttachment =
    I.Single identity "background-attachment"


backgroundAttachmentJ : List String -> Declaration
backgroundAttachmentJ =
    I.Single identity "background-attachment" << String.join " "


backgroundBlendMode : String -> Declaration
backgroundBlendMode =
    I.Single identity "background-blend-mode"


backgroundBlendModeJ : List String -> Declaration
backgroundBlendModeJ =
    I.Single identity "background-blend-mode" << String.join " "


backgroundClip : String -> Declaration
backgroundClip =
    I.Single identity "background-clip"


backgroundClipJ : List String -> Declaration
backgroundClipJ =
    I.Single identity "background-clip" << String.join " "


backgroundColor : String -> Declaration
backgroundColor =
    I.Single identity "background-color"


backgroundColorJ : List String -> Declaration
backgroundColorJ =
    I.Single identity "background-color" << String.join " "


backgroundImage : String -> Declaration
backgroundImage =
    I.Single identity "background-image"


backgroundImageJ : List String -> Declaration
backgroundImageJ =
    I.Single identity "background-image" << String.join " "


backgroundOrigin : String -> Declaration
backgroundOrigin =
    I.Single identity "background-origin"


backgroundOriginJ : List String -> Declaration
backgroundOriginJ =
    I.Single identity "background-origin" << String.join " "


backgroundPosition : String -> Declaration
backgroundPosition =
    I.Single identity "background-position"


backgroundPositionJ : List String -> Declaration
backgroundPositionJ =
    I.Single identity "background-position" << String.join " "


backgroundRepeat : String -> Declaration
backgroundRepeat =
    I.Single identity "background-repeat"


backgroundRepeatJ : List String -> Declaration
backgroundRepeatJ =
    I.Single identity "background-repeat" << String.join " "


backgroundSize : String -> Declaration
backgroundSize =
    I.Single identity "background-size"


backgroundSizeJ : List String -> Declaration
backgroundSizeJ =
    I.Single identity "background-size" << String.join " "


baselineShift : String -> Declaration
baselineShift =
    I.Single identity "baseline-shift"


baselineShiftJ : List String -> Declaration
baselineShiftJ =
    I.Single identity "baseline-shift" << String.join " "


blockOverflow : String -> Declaration
blockOverflow =
    I.Single identity "block-overflow"


blockOverflowJ : List String -> Declaration
blockOverflowJ =
    I.Single identity "block-overflow" << String.join " "


blockSize : String -> Declaration
blockSize =
    I.Single identity "block-size"


blockSizeJ : List String -> Declaration
blockSizeJ =
    I.Single identity "block-size" << String.join " "


blockStep : String -> Declaration
blockStep =
    I.Single identity "block-step"


blockStepJ : List String -> Declaration
blockStepJ =
    I.Single identity "block-step" << String.join " "


blockStepAlign : String -> Declaration
blockStepAlign =
    I.Single identity "block-step-align"


blockStepAlignJ : List String -> Declaration
blockStepAlignJ =
    I.Single identity "block-step-align" << String.join " "


blockStepInsert : String -> Declaration
blockStepInsert =
    I.Single identity "block-step-insert"


blockStepInsertJ : List String -> Declaration
blockStepInsertJ =
    I.Single identity "block-step-insert" << String.join " "


blockStepRound : String -> Declaration
blockStepRound =
    I.Single identity "block-step-round"


blockStepRoundJ : List String -> Declaration
blockStepRoundJ =
    I.Single identity "block-step-round" << String.join " "


blockStepSize : String -> Declaration
blockStepSize =
    I.Single identity "block-step-size"


blockStepSizeJ : List String -> Declaration
blockStepSizeJ =
    I.Single identity "block-step-size" << String.join " "


bookmarkLabel : String -> Declaration
bookmarkLabel =
    I.Single identity "bookmark-label"


bookmarkLabelJ : List String -> Declaration
bookmarkLabelJ =
    I.Single identity "bookmark-label" << String.join " "


bookmarkLevel : String -> Declaration
bookmarkLevel =
    I.Single identity "bookmark-level"


bookmarkLevelJ : List String -> Declaration
bookmarkLevelJ =
    I.Single identity "bookmark-level" << String.join " "


bookmarkState : String -> Declaration
bookmarkState =
    I.Single identity "bookmark-state"


bookmarkStateJ : List String -> Declaration
bookmarkStateJ =
    I.Single identity "bookmark-state" << String.join " "


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


borderBlockEndColor : String -> Declaration
borderBlockEndColor =
    I.Single identity "border-block-end-color"


borderBlockEndColorJ : List String -> Declaration
borderBlockEndColorJ =
    I.Single identity "border-block-end-color" << String.join " "


borderBlockEndStyle : String -> Declaration
borderBlockEndStyle =
    I.Single identity "border-block-end-style"


borderBlockEndStyleJ : List String -> Declaration
borderBlockEndStyleJ =
    I.Single identity "border-block-end-style" << String.join " "


borderBlockEndWidth : String -> Declaration
borderBlockEndWidth =
    I.Single identity "border-block-end-width"


borderBlockEndWidthJ : List String -> Declaration
borderBlockEndWidthJ =
    I.Single identity "border-block-end-width" << String.join " "


borderBlockStart : String -> Declaration
borderBlockStart =
    I.Single identity "border-block-start"


borderBlockStartJ : List String -> Declaration
borderBlockStartJ =
    I.Single identity "border-block-start" << String.join " "


borderBlockStartColor : String -> Declaration
borderBlockStartColor =
    I.Single identity "border-block-start-color"


borderBlockStartColorJ : List String -> Declaration
borderBlockStartColorJ =
    I.Single identity "border-block-start-color" << String.join " "


borderBlockStartStyle : String -> Declaration
borderBlockStartStyle =
    I.Single identity "border-block-start-style"


borderBlockStartStyleJ : List String -> Declaration
borderBlockStartStyleJ =
    I.Single identity "border-block-start-style" << String.join " "


borderBlockStartWidth : String -> Declaration
borderBlockStartWidth =
    I.Single identity "border-block-start-width"


borderBlockStartWidthJ : List String -> Declaration
borderBlockStartWidthJ =
    I.Single identity "border-block-start-width" << String.join " "


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


borderBottomColor : String -> Declaration
borderBottomColor =
    I.Single identity "border-bottom-color"


borderBottomColorJ : List String -> Declaration
borderBottomColorJ =
    I.Single identity "border-bottom-color" << String.join " "


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


borderBottomStyle : String -> Declaration
borderBottomStyle =
    I.Single identity "border-bottom-style"


borderBottomStyleJ : List String -> Declaration
borderBottomStyleJ =
    I.Single identity "border-bottom-style" << String.join " "


borderBottomWidth : String -> Declaration
borderBottomWidth =
    I.Single identity "border-bottom-width"


borderBottomWidthJ : List String -> Declaration
borderBottomWidthJ =
    I.Single identity "border-bottom-width" << String.join " "


borderBoundary : String -> Declaration
borderBoundary =
    I.Single identity "border-boundary"


borderBoundaryJ : List String -> Declaration
borderBoundaryJ =
    I.Single identity "border-boundary" << String.join " "


borderCollapse : String -> Declaration
borderCollapse =
    I.Single identity "border-collapse"


borderCollapseJ : List String -> Declaration
borderCollapseJ =
    I.Single identity "border-collapse" << String.join " "


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


borderImageSource : String -> Declaration
borderImageSource =
    I.Single identity "border-image-source"


borderImageSourceJ : List String -> Declaration
borderImageSourceJ =
    I.Single identity "border-image-source" << String.join " "


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


borderInlineEndColor : String -> Declaration
borderInlineEndColor =
    I.Single identity "border-inline-end-color"


borderInlineEndColorJ : List String -> Declaration
borderInlineEndColorJ =
    I.Single identity "border-inline-end-color" << String.join " "


borderInlineEndStyle : String -> Declaration
borderInlineEndStyle =
    I.Single identity "border-inline-end-style"


borderInlineEndStyleJ : List String -> Declaration
borderInlineEndStyleJ =
    I.Single identity "border-inline-end-style" << String.join " "


borderInlineEndWidth : String -> Declaration
borderInlineEndWidth =
    I.Single identity "border-inline-end-width"


borderInlineEndWidthJ : List String -> Declaration
borderInlineEndWidthJ =
    I.Single identity "border-inline-end-width" << String.join " "


borderInlineStart : String -> Declaration
borderInlineStart =
    I.Single identity "border-inline-start"


borderInlineStartJ : List String -> Declaration
borderInlineStartJ =
    I.Single identity "border-inline-start" << String.join " "


borderInlineStartColor : String -> Declaration
borderInlineStartColor =
    I.Single identity "border-inline-start-color"


borderInlineStartColorJ : List String -> Declaration
borderInlineStartColorJ =
    I.Single identity "border-inline-start-color" << String.join " "


borderInlineStartStyle : String -> Declaration
borderInlineStartStyle =
    I.Single identity "border-inline-start-style"


borderInlineStartStyleJ : List String -> Declaration
borderInlineStartStyleJ =
    I.Single identity "border-inline-start-style" << String.join " "


borderInlineStartWidth : String -> Declaration
borderInlineStartWidth =
    I.Single identity "border-inline-start-width"


borderInlineStartWidthJ : List String -> Declaration
borderInlineStartWidthJ =
    I.Single identity "border-inline-start-width" << String.join " "


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


borderLeftColor : String -> Declaration
borderLeftColor =
    I.Single identity "border-left-color"


borderLeftColorJ : List String -> Declaration
borderLeftColorJ =
    I.Single identity "border-left-color" << String.join " "


borderLeftStyle : String -> Declaration
borderLeftStyle =
    I.Single identity "border-left-style"


borderLeftStyleJ : List String -> Declaration
borderLeftStyleJ =
    I.Single identity "border-left-style" << String.join " "


borderLeftWidth : String -> Declaration
borderLeftWidth =
    I.Single identity "border-left-width"


borderLeftWidthJ : List String -> Declaration
borderLeftWidthJ =
    I.Single identity "border-left-width" << String.join " "


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


borderRightColor : String -> Declaration
borderRightColor =
    I.Single identity "border-right-color"


borderRightColorJ : List String -> Declaration
borderRightColorJ =
    I.Single identity "border-right-color" << String.join " "


borderRightStyle : String -> Declaration
borderRightStyle =
    I.Single identity "border-right-style"


borderRightStyleJ : List String -> Declaration
borderRightStyleJ =
    I.Single identity "border-right-style" << String.join " "


borderRightWidth : String -> Declaration
borderRightWidth =
    I.Single identity "border-right-width"


borderRightWidthJ : List String -> Declaration
borderRightWidthJ =
    I.Single identity "border-right-width" << String.join " "


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


borderTopColor : String -> Declaration
borderTopColor =
    I.Single identity "border-top-color"


borderTopColorJ : List String -> Declaration
borderTopColorJ =
    I.Single identity "border-top-color" << String.join " "


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


borderTopStyle : String -> Declaration
borderTopStyle =
    I.Single identity "border-top-style"


borderTopStyleJ : List String -> Declaration
borderTopStyleJ =
    I.Single identity "border-top-style" << String.join " "


borderTopWidth : String -> Declaration
borderTopWidth =
    I.Single identity "border-top-width"


borderTopWidthJ : List String -> Declaration
borderTopWidthJ =
    I.Single identity "border-top-width" << String.join " "


borderWidth : String -> Declaration
borderWidth =
    I.Single identity "border-width"


borderWidthJ : List String -> Declaration
borderWidthJ =
    I.Single identity "border-width" << String.join " "


bottom : String -> Declaration
bottom =
    I.Single identity "bottom"


bottomJ : List String -> Declaration
bottomJ =
    I.Single identity "bottom" << String.join " "


boxDecorationBreak : String -> Declaration
boxDecorationBreak =
    I.Single identity "box-decoration-break"


boxDecorationBreakJ : List String -> Declaration
boxDecorationBreakJ =
    I.Single identity "box-decoration-break" << String.join " "


boxShadow : String -> Declaration
boxShadow =
    I.Single identity "box-shadow"


boxShadowJ : List String -> Declaration
boxShadowJ =
    I.Single identity "box-shadow" << String.join " "


boxSizing : String -> Declaration
boxSizing =
    I.Single identity "box-sizing"


boxSizingJ : List String -> Declaration
boxSizingJ =
    I.Single identity "box-sizing" << String.join " "


boxSnap : String -> Declaration
boxSnap =
    I.Single identity "box-snap"


boxSnapJ : List String -> Declaration
boxSnapJ =
    I.Single identity "box-snap" << String.join " "


breakAfter : String -> Declaration
breakAfter =
    I.Single identity "break-after"


breakAfterJ : List String -> Declaration
breakAfterJ =
    I.Single identity "break-after" << String.join " "


breakBefore : String -> Declaration
breakBefore =
    I.Single identity "break-before"


breakBeforeJ : List String -> Declaration
breakBeforeJ =
    I.Single identity "break-before" << String.join " "


breakInside : String -> Declaration
breakInside =
    I.Single identity "break-inside"


breakInsideJ : List String -> Declaration
breakInsideJ =
    I.Single identity "break-inside" << String.join " "


captionSide : String -> Declaration
captionSide =
    I.Single identity "caption-side"


captionSideJ : List String -> Declaration
captionSideJ =
    I.Single identity "caption-side" << String.join " "


caret : String -> Declaration
caret =
    I.Single identity "caret"


caretJ : List String -> Declaration
caretJ =
    I.Single identity "caret" << String.join " "


caretColor : String -> Declaration
caretColor =
    I.Single identity "caret-color"


caretColorJ : List String -> Declaration
caretColorJ =
    I.Single identity "caret-color" << String.join " "


caretShape : String -> Declaration
caretShape =
    I.Single identity "caret-shape"


caretShapeJ : List String -> Declaration
caretShapeJ =
    I.Single identity "caret-shape" << String.join " "


clear : String -> Declaration
clear =
    I.Single identity "clear"


clearJ : List String -> Declaration
clearJ =
    I.Single identity "clear" << String.join " "


clip : String -> Declaration
clip =
    I.Single identity "clip"


clipJ : List String -> Declaration
clipJ =
    I.Single identity "clip" << String.join " "


clipPath : String -> Declaration
clipPath =
    I.Single identity "clip-path"


clipPathJ : List String -> Declaration
clipPathJ =
    I.Single identity "clip-path" << String.join " "


clipRule : String -> Declaration
clipRule =
    I.Single identity "clip-rule"


clipRuleJ : List String -> Declaration
clipRuleJ =
    I.Single identity "clip-rule" << String.join " "


color : String -> Declaration
color =
    I.Single identity "color"


colorJ : List String -> Declaration
colorJ =
    I.Single identity "color" << String.join " "


colorAdjust : String -> Declaration
colorAdjust =
    I.Single identity "color-adjust"


colorAdjustJ : List String -> Declaration
colorAdjustJ =
    I.Single identity "color-adjust" << String.join " "


colorInterpolationFilters : String -> Declaration
colorInterpolationFilters =
    I.Single identity "color-interpolation-filters"


colorInterpolationFiltersJ : List String -> Declaration
colorInterpolationFiltersJ =
    I.Single identity "color-interpolation-filters" << String.join " "


colorScheme : String -> Declaration
colorScheme =
    I.Single identity "color-scheme"


colorSchemeJ : List String -> Declaration
colorSchemeJ =
    I.Single identity "color-scheme" << String.join " "


columnCount : String -> Declaration
columnCount =
    I.Single identity "column-count"


columnCountJ : List String -> Declaration
columnCountJ =
    I.Single identity "column-count" << String.join " "


columnFill : String -> Declaration
columnFill =
    I.Single identity "column-fill"


columnFillJ : List String -> Declaration
columnFillJ =
    I.Single identity "column-fill" << String.join " "


columnGap : String -> Declaration
columnGap =
    I.Single identity "column-gap"


columnGapJ : List String -> Declaration
columnGapJ =
    I.Single identity "column-gap" << String.join " "


columnRule : String -> Declaration
columnRule =
    I.Single identity "column-rule"


columnRuleJ : List String -> Declaration
columnRuleJ =
    I.Single identity "column-rule" << String.join " "


columnRuleColor : String -> Declaration
columnRuleColor =
    I.Single identity "column-rule-color"


columnRuleColorJ : List String -> Declaration
columnRuleColorJ =
    I.Single identity "column-rule-color" << String.join " "


columnRuleStyle : String -> Declaration
columnRuleStyle =
    I.Single identity "column-rule-style"


columnRuleStyleJ : List String -> Declaration
columnRuleStyleJ =
    I.Single identity "column-rule-style" << String.join " "


columnRuleWidth : String -> Declaration
columnRuleWidth =
    I.Single identity "column-rule-width"


columnRuleWidthJ : List String -> Declaration
columnRuleWidthJ =
    I.Single identity "column-rule-width" << String.join " "


columnSpan : String -> Declaration
columnSpan =
    I.Single identity "column-span"


columnSpanJ : List String -> Declaration
columnSpanJ =
    I.Single identity "column-span" << String.join " "


columnWidth : String -> Declaration
columnWidth =
    I.Single identity "column-width"


columnWidthJ : List String -> Declaration
columnWidthJ =
    I.Single identity "column-width" << String.join " "


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


continue : String -> Declaration
continue =
    I.Single identity "continue"


continueJ : List String -> Declaration
continueJ =
    I.Single identity "continue" << String.join " "


counterIncrement : String -> Declaration
counterIncrement =
    I.Single identity "counter-increment"


counterIncrementJ : List String -> Declaration
counterIncrementJ =
    I.Single identity "counter-increment" << String.join " "


counterReset : String -> Declaration
counterReset =
    I.Single identity "counter-reset"


counterResetJ : List String -> Declaration
counterResetJ =
    I.Single identity "counter-reset" << String.join " "


counterSet : String -> Declaration
counterSet =
    I.Single identity "counter-set"


counterSetJ : List String -> Declaration
counterSetJ =
    I.Single identity "counter-set" << String.join " "


cue : String -> Declaration
cue =
    I.Single identity "cue"


cueJ : List String -> Declaration
cueJ =
    I.Single identity "cue" << String.join " "


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


cursor : String -> Declaration
cursor =
    I.Single identity "cursor"


cursorJ : List String -> Declaration
cursorJ =
    I.Single identity "cursor" << String.join " "


direction : String -> Declaration
direction =
    I.Single identity "direction"


directionJ : List String -> Declaration
directionJ =
    I.Single identity "direction" << String.join " "


display : String -> Declaration
display =
    I.Single identity "display"


displayJ : List String -> Declaration
displayJ =
    I.Single identity "display" << String.join " "


dominantBaseline : String -> Declaration
dominantBaseline =
    I.Single identity "dominant-baseline"


dominantBaselineJ : List String -> Declaration
dominantBaselineJ =
    I.Single identity "dominant-baseline" << String.join " "


elevation : String -> Declaration
elevation =
    I.Single identity "elevation"


elevationJ : List String -> Declaration
elevationJ =
    I.Single identity "elevation" << String.join " "


emptyCells : String -> Declaration
emptyCells =
    I.Single identity "empty-cells"


emptyCellsJ : List String -> Declaration
emptyCellsJ =
    I.Single identity "empty-cells" << String.join " "


fill : String -> Declaration
fill =
    I.Single identity "fill"


fillJ : List String -> Declaration
fillJ =
    I.Single identity "fill" << String.join " "


fillBreak : String -> Declaration
fillBreak =
    I.Single identity "fill-break"


fillBreakJ : List String -> Declaration
fillBreakJ =
    I.Single identity "fill-break" << String.join " "


fillColor : String -> Declaration
fillColor =
    I.Single identity "fill-color"


fillColorJ : List String -> Declaration
fillColorJ =
    I.Single identity "fill-color" << String.join " "


fillImage : String -> Declaration
fillImage =
    I.Single identity "fill-image"


fillImageJ : List String -> Declaration
fillImageJ =
    I.Single identity "fill-image" << String.join " "


fillOpacity : String -> Declaration
fillOpacity =
    I.Single identity "fill-opacity"


fillOpacityJ : List String -> Declaration
fillOpacityJ =
    I.Single identity "fill-opacity" << String.join " "


fillOrigin : String -> Declaration
fillOrigin =
    I.Single identity "fill-origin"


fillOriginJ : List String -> Declaration
fillOriginJ =
    I.Single identity "fill-origin" << String.join " "


fillPosition : String -> Declaration
fillPosition =
    I.Single identity "fill-position"


fillPositionJ : List String -> Declaration
fillPositionJ =
    I.Single identity "fill-position" << String.join " "


fillRepeat : String -> Declaration
fillRepeat =
    I.Single identity "fill-repeat"


fillRepeatJ : List String -> Declaration
fillRepeatJ =
    I.Single identity "fill-repeat" << String.join " "


fillRule : String -> Declaration
fillRule =
    I.Single identity "fill-rule"


fillRuleJ : List String -> Declaration
fillRuleJ =
    I.Single identity "fill-rule" << String.join " "


fillSize : String -> Declaration
fillSize =
    I.Single identity "fill-size"


fillSizeJ : List String -> Declaration
fillSizeJ =
    I.Single identity "fill-size" << String.join " "


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


flexBasis : String -> Declaration
flexBasis =
    I.Single identity "flex-basis"


flexBasisJ : List String -> Declaration
flexBasisJ =
    I.Single identity "flex-basis" << String.join " "


flexDirection : String -> Declaration
flexDirection =
    I.Single identity "flex-direction"


flexDirectionJ : List String -> Declaration
flexDirectionJ =
    I.Single identity "flex-direction" << String.join " "


flexFlow : String -> Declaration
flexFlow =
    I.Single identity "flex-flow"


flexFlowJ : List String -> Declaration
flexFlowJ =
    I.Single identity "flex-flow" << String.join " "


flexGrow : String -> Declaration
flexGrow =
    I.Single identity "flex-grow"


flexGrowJ : List String -> Declaration
flexGrowJ =
    I.Single identity "flex-grow" << String.join " "


flexShrink : String -> Declaration
flexShrink =
    I.Single identity "flex-shrink"


flexShrinkJ : List String -> Declaration
flexShrinkJ =
    I.Single identity "flex-shrink" << String.join " "


flexWrap : String -> Declaration
flexWrap =
    I.Single identity "flex-wrap"


flexWrapJ : List String -> Declaration
flexWrapJ =
    I.Single identity "flex-wrap" << String.join " "


float : String -> Declaration
float =
    I.Single identity "float"


floatJ : List String -> Declaration
floatJ =
    I.Single identity "float" << String.join " "


floatDefer : String -> Declaration
floatDefer =
    I.Single identity "float-defer"


floatDeferJ : List String -> Declaration
floatDeferJ =
    I.Single identity "float-defer" << String.join " "


floatOffset : String -> Declaration
floatOffset =
    I.Single identity "float-offset"


floatOffsetJ : List String -> Declaration
floatOffsetJ =
    I.Single identity "float-offset" << String.join " "


floatReference : String -> Declaration
floatReference =
    I.Single identity "float-reference"


floatReferenceJ : List String -> Declaration
floatReferenceJ =
    I.Single identity "float-reference" << String.join " "


floodColor : String -> Declaration
floodColor =
    I.Single identity "flood-color"


floodColorJ : List String -> Declaration
floodColorJ =
    I.Single identity "flood-color" << String.join " "


floodOpacity : String -> Declaration
floodOpacity =
    I.Single identity "flood-opacity"


floodOpacityJ : List String -> Declaration
floodOpacityJ =
    I.Single identity "flood-opacity" << String.join " "


flowFrom : String -> Declaration
flowFrom =
    I.Single identity "flow-from"


flowFromJ : List String -> Declaration
flowFromJ =
    I.Single identity "flow-from" << String.join " "


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


fontFamily : String -> Declaration
fontFamily =
    I.Single identity "font-family"


fontFamilyJ : List String -> Declaration
fontFamilyJ =
    I.Single identity "font-family" << String.join " "


fontFeatureSettings : String -> Declaration
fontFeatureSettings =
    I.Single identity "font-feature-settings"


fontFeatureSettingsJ : List String -> Declaration
fontFeatureSettingsJ =
    I.Single identity "font-feature-settings" << String.join " "


fontKerning : String -> Declaration
fontKerning =
    I.Single identity "font-kerning"


fontKerningJ : List String -> Declaration
fontKerningJ =
    I.Single identity "font-kerning" << String.join " "


fontLanguageOverride : String -> Declaration
fontLanguageOverride =
    I.Single identity "font-language-override"


fontLanguageOverrideJ : List String -> Declaration
fontLanguageOverrideJ =
    I.Single identity "font-language-override" << String.join " "


fontOpticalSizing : String -> Declaration
fontOpticalSizing =
    I.Single identity "font-optical-sizing"


fontOpticalSizingJ : List String -> Declaration
fontOpticalSizingJ =
    I.Single identity "font-optical-sizing" << String.join " "


fontPalette : String -> Declaration
fontPalette =
    I.Single identity "font-palette"


fontPaletteJ : List String -> Declaration
fontPaletteJ =
    I.Single identity "font-palette" << String.join " "


fontSize : String -> Declaration
fontSize =
    I.Single identity "font-size"


fontSizeJ : List String -> Declaration
fontSizeJ =
    I.Single identity "font-size" << String.join " "


fontSizeAdjust : String -> Declaration
fontSizeAdjust =
    I.Single identity "font-size-adjust"


fontSizeAdjustJ : List String -> Declaration
fontSizeAdjustJ =
    I.Single identity "font-size-adjust" << String.join " "


fontStretch : String -> Declaration
fontStretch =
    I.Single identity "font-stretch"


fontStretchJ : List String -> Declaration
fontStretchJ =
    I.Single identity "font-stretch" << String.join " "


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


fontSynthesisSmallCaps : String -> Declaration
fontSynthesisSmallCaps =
    I.Single identity "font-synthesis-small-caps"


fontSynthesisSmallCapsJ : List String -> Declaration
fontSynthesisSmallCapsJ =
    I.Single identity "font-synthesis-small-caps" << String.join " "


fontSynthesisStyle : String -> Declaration
fontSynthesisStyle =
    I.Single identity "font-synthesis-style"


fontSynthesisStyleJ : List String -> Declaration
fontSynthesisStyleJ =
    I.Single identity "font-synthesis-style" << String.join " "


fontSynthesisWeight : String -> Declaration
fontSynthesisWeight =
    I.Single identity "font-synthesis-weight"


fontSynthesisWeightJ : List String -> Declaration
fontSynthesisWeightJ =
    I.Single identity "font-synthesis-weight" << String.join " "


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


fontVariantCaps : String -> Declaration
fontVariantCaps =
    I.Single identity "font-variant-caps"


fontVariantCapsJ : List String -> Declaration
fontVariantCapsJ =
    I.Single identity "font-variant-caps" << String.join " "


fontVariantEastAsian : String -> Declaration
fontVariantEastAsian =
    I.Single identity "font-variant-east-asian"


fontVariantEastAsianJ : List String -> Declaration
fontVariantEastAsianJ =
    I.Single identity "font-variant-east-asian" << String.join " "


fontVariantEmoji : String -> Declaration
fontVariantEmoji =
    I.Single identity "font-variant-emoji"


fontVariantEmojiJ : List String -> Declaration
fontVariantEmojiJ =
    I.Single identity "font-variant-emoji" << String.join " "


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


fontVariantPosition : String -> Declaration
fontVariantPosition =
    I.Single identity "font-variant-position"


fontVariantPositionJ : List String -> Declaration
fontVariantPositionJ =
    I.Single identity "font-variant-position" << String.join " "


fontVariationSettings : String -> Declaration
fontVariationSettings =
    I.Single identity "font-variation-settings"


fontVariationSettingsJ : List String -> Declaration
fontVariationSettingsJ =
    I.Single identity "font-variation-settings" << String.join " "


fontWeight : String -> Declaration
fontWeight =
    I.Single identity "font-weight"


fontWeightJ : List String -> Declaration
fontWeightJ =
    I.Single identity "font-weight" << String.join " "


footnoteDisplay : String -> Declaration
footnoteDisplay =
    I.Single identity "footnote-display"


footnoteDisplayJ : List String -> Declaration
footnoteDisplayJ =
    I.Single identity "footnote-display" << String.join " "


footnotePolicy : String -> Declaration
footnotePolicy =
    I.Single identity "footnote-policy"


footnotePolicyJ : List String -> Declaration
footnotePolicyJ =
    I.Single identity "footnote-policy" << String.join " "


forcedColorAdjust : String -> Declaration
forcedColorAdjust =
    I.Single identity "forced-color-adjust"


forcedColorAdjustJ : List String -> Declaration
forcedColorAdjustJ =
    I.Single identity "forced-color-adjust" << String.join " "


gap : String -> Declaration
gap =
    I.Single identity "gap"


gapJ : List String -> Declaration
gapJ =
    I.Single identity "gap" << String.join " "


glyphOrientationVertical : String -> Declaration
glyphOrientationVertical =
    I.Single identity "glyph-orientation-vertical"


glyphOrientationVerticalJ : List String -> Declaration
glyphOrientationVerticalJ =
    I.Single identity "glyph-orientation-vertical" << String.join " "


grid : String -> Declaration
grid =
    I.Single identity "grid"


gridJ : List String -> Declaration
gridJ =
    I.Single identity "grid" << String.join " "


gridArea : String -> Declaration
gridArea =
    I.Single identity "grid-area"


gridAreaJ : List String -> Declaration
gridAreaJ =
    I.Single identity "grid-area" << String.join " "


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


gridColumn : String -> Declaration
gridColumn =
    I.Single identity "grid-column"


gridColumnJ : List String -> Declaration
gridColumnJ =
    I.Single identity "grid-column" << String.join " "


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


gridRow : String -> Declaration
gridRow =
    I.Single identity "grid-row"


gridRowJ : List String -> Declaration
gridRowJ =
    I.Single identity "grid-row" << String.join " "


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


gridTemplate : String -> Declaration
gridTemplate =
    I.Single identity "grid-template"


gridTemplateJ : List String -> Declaration
gridTemplateJ =
    I.Single identity "grid-template" << String.join " "


gridTemplateAreas : String -> Declaration
gridTemplateAreas =
    I.Single identity "grid-template-areas"


gridTemplateAreasJ : List String -> Declaration
gridTemplateAreasJ =
    I.Single identity "grid-template-areas" << String.join " "


gridTemplateColumns : String -> Declaration
gridTemplateColumns =
    I.Single identity "grid-template-columns"


gridTemplateColumnsJ : List String -> Declaration
gridTemplateColumnsJ =
    I.Single identity "grid-template-columns" << String.join " "


gridTemplateRows : String -> Declaration
gridTemplateRows =
    I.Single identity "grid-template-rows"


gridTemplateRowsJ : List String -> Declaration
gridTemplateRowsJ =
    I.Single identity "grid-template-rows" << String.join " "


hangingPunctuation : String -> Declaration
hangingPunctuation =
    I.Single identity "hanging-punctuation"


hangingPunctuationJ : List String -> Declaration
hangingPunctuationJ =
    I.Single identity "hanging-punctuation" << String.join " "


height : String -> Declaration
height =
    I.Single identity "height"


heightJ : List String -> Declaration
heightJ =
    I.Single identity "height" << String.join " "


hyphenateCharacter : String -> Declaration
hyphenateCharacter =
    I.Single identity "hyphenate-character"


hyphenateCharacterJ : List String -> Declaration
hyphenateCharacterJ =
    I.Single identity "hyphenate-character" << String.join " "


hyphenateLimitChars : String -> Declaration
hyphenateLimitChars =
    I.Single identity "hyphenate-limit-chars"


hyphenateLimitCharsJ : List String -> Declaration
hyphenateLimitCharsJ =
    I.Single identity "hyphenate-limit-chars" << String.join " "


hyphenateLimitLast : String -> Declaration
hyphenateLimitLast =
    I.Single identity "hyphenate-limit-last"


hyphenateLimitLastJ : List String -> Declaration
hyphenateLimitLastJ =
    I.Single identity "hyphenate-limit-last" << String.join " "


hyphenateLimitLines : String -> Declaration
hyphenateLimitLines =
    I.Single identity "hyphenate-limit-lines"


hyphenateLimitLinesJ : List String -> Declaration
hyphenateLimitLinesJ =
    I.Single identity "hyphenate-limit-lines" << String.join " "


hyphenateLimitZone : String -> Declaration
hyphenateLimitZone =
    I.Single identity "hyphenate-limit-zone"


hyphenateLimitZoneJ : List String -> Declaration
hyphenateLimitZoneJ =
    I.Single identity "hyphenate-limit-zone" << String.join " "


hyphens : String -> Declaration
hyphens =
    I.Single identity "hyphens"


hyphensJ : List String -> Declaration
hyphensJ =
    I.Single identity "hyphens" << String.join " "


imageOrientation : String -> Declaration
imageOrientation =
    I.Single identity "image-orientation"


imageOrientationJ : List String -> Declaration
imageOrientationJ =
    I.Single identity "image-orientation" << String.join " "


imageRendering : String -> Declaration
imageRendering =
    I.Single identity "image-rendering"


imageRenderingJ : List String -> Declaration
imageRenderingJ =
    I.Single identity "image-rendering" << String.join " "


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


initialLettersWrap : String -> Declaration
initialLettersWrap =
    I.Single identity "initial-letters-wrap"


initialLettersWrapJ : List String -> Declaration
initialLettersWrapJ =
    I.Single identity "initial-letters-wrap" << String.join " "


inlineSize : String -> Declaration
inlineSize =
    I.Single identity "inline-size"


inlineSizeJ : List String -> Declaration
inlineSizeJ =
    I.Single identity "inline-size" << String.join " "


inlineSizing : String -> Declaration
inlineSizing =
    I.Single identity "inline-sizing"


inlineSizingJ : List String -> Declaration
inlineSizingJ =
    I.Single identity "inline-sizing" << String.join " "


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


insetBlockEnd : String -> Declaration
insetBlockEnd =
    I.Single identity "inset-block-end"


insetBlockEndJ : List String -> Declaration
insetBlockEndJ =
    I.Single identity "inset-block-end" << String.join " "


insetBlockStart : String -> Declaration
insetBlockStart =
    I.Single identity "inset-block-start"


insetBlockStartJ : List String -> Declaration
insetBlockStartJ =
    I.Single identity "inset-block-start" << String.join " "


insetInline : String -> Declaration
insetInline =
    I.Single identity "inset-inline"


insetInlineJ : List String -> Declaration
insetInlineJ =
    I.Single identity "inset-inline" << String.join " "


insetInlineEnd : String -> Declaration
insetInlineEnd =
    I.Single identity "inset-inline-end"


insetInlineEndJ : List String -> Declaration
insetInlineEndJ =
    I.Single identity "inset-inline-end" << String.join " "


insetInlineStart : String -> Declaration
insetInlineStart =
    I.Single identity "inset-inline-start"


insetInlineStartJ : List String -> Declaration
insetInlineStartJ =
    I.Single identity "inset-inline-start" << String.join " "


isolation : String -> Declaration
isolation =
    I.Single identity "isolation"


isolationJ : List String -> Declaration
isolationJ =
    I.Single identity "isolation" << String.join " "


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


left : String -> Declaration
left =
    I.Single identity "left"


leftJ : List String -> Declaration
leftJ =
    I.Single identity "left" << String.join " "


letterSpacing : String -> Declaration
letterSpacing =
    I.Single identity "letter-spacing"


letterSpacingJ : List String -> Declaration
letterSpacingJ =
    I.Single identity "letter-spacing" << String.join " "


lightingColor : String -> Declaration
lightingColor =
    I.Single identity "lighting-color"


lightingColorJ : List String -> Declaration
lightingColorJ =
    I.Single identity "lighting-color" << String.join " "


lineBreak : String -> Declaration
lineBreak =
    I.Single identity "line-break"


lineBreakJ : List String -> Declaration
lineBreakJ =
    I.Single identity "line-break" << String.join " "


lineClamp : String -> Declaration
lineClamp =
    I.Single identity "line-clamp"


lineClampJ : List String -> Declaration
lineClampJ =
    I.Single identity "line-clamp" << String.join " "


lineGrid : String -> Declaration
lineGrid =
    I.Single identity "line-grid"


lineGridJ : List String -> Declaration
lineGridJ =
    I.Single identity "line-grid" << String.join " "


lineHeight : String -> Declaration
lineHeight =
    I.Single identity "line-height"


lineHeightJ : List String -> Declaration
lineHeightJ =
    I.Single identity "line-height" << String.join " "


lineHeightStep : String -> Declaration
lineHeightStep =
    I.Single identity "line-height-step"


lineHeightStepJ : List String -> Declaration
lineHeightStepJ =
    I.Single identity "line-height-step" << String.join " "


linePadding : String -> Declaration
linePadding =
    I.Single identity "line-padding"


linePaddingJ : List String -> Declaration
linePaddingJ =
    I.Single identity "line-padding" << String.join " "


lineSnap : String -> Declaration
lineSnap =
    I.Single identity "line-snap"


lineSnapJ : List String -> Declaration
lineSnapJ =
    I.Single identity "line-snap" << String.join " "


listStyle : String -> Declaration
listStyle =
    I.Single identity "list-style"


listStyleJ : List String -> Declaration
listStyleJ =
    I.Single identity "list-style" << String.join " "


listStyleImage : String -> Declaration
listStyleImage =
    I.Single identity "list-style-image"


listStyleImageJ : List String -> Declaration
listStyleImageJ =
    I.Single identity "list-style-image" << String.join " "


listStylePosition : String -> Declaration
listStylePosition =
    I.Single identity "list-style-position"


listStylePositionJ : List String -> Declaration
listStylePositionJ =
    I.Single identity "list-style-position" << String.join " "


listStyleType : String -> Declaration
listStyleType =
    I.Single identity "list-style-type"


listStyleTypeJ : List String -> Declaration
listStyleTypeJ =
    I.Single identity "list-style-type" << String.join " "


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


marginBlockEnd : String -> Declaration
marginBlockEnd =
    I.Single identity "margin-block-end"


marginBlockEndJ : List String -> Declaration
marginBlockEndJ =
    I.Single identity "margin-block-end" << String.join " "


marginBlockStart : String -> Declaration
marginBlockStart =
    I.Single identity "margin-block-start"


marginBlockStartJ : List String -> Declaration
marginBlockStartJ =
    I.Single identity "margin-block-start" << String.join " "


marginBottom : String -> Declaration
marginBottom =
    I.Single identity "margin-bottom"


marginBottomJ : List String -> Declaration
marginBottomJ =
    I.Single identity "margin-bottom" << String.join " "


marginBreak : String -> Declaration
marginBreak =
    I.Single identity "margin-break"


marginBreakJ : List String -> Declaration
marginBreakJ =
    I.Single identity "margin-break" << String.join " "


marginInline : String -> Declaration
marginInline =
    I.Single identity "margin-inline"


marginInlineJ : List String -> Declaration
marginInlineJ =
    I.Single identity "margin-inline" << String.join " "


marginInlineEnd : String -> Declaration
marginInlineEnd =
    I.Single identity "margin-inline-end"


marginInlineEndJ : List String -> Declaration
marginInlineEndJ =
    I.Single identity "margin-inline-end" << String.join " "


marginInlineStart : String -> Declaration
marginInlineStart =
    I.Single identity "margin-inline-start"


marginInlineStartJ : List String -> Declaration
marginInlineStartJ =
    I.Single identity "margin-inline-start" << String.join " "


marginLeft : String -> Declaration
marginLeft =
    I.Single identity "margin-left"


marginLeftJ : List String -> Declaration
marginLeftJ =
    I.Single identity "margin-left" << String.join " "


marginRight : String -> Declaration
marginRight =
    I.Single identity "margin-right"


marginRightJ : List String -> Declaration
marginRightJ =
    I.Single identity "margin-right" << String.join " "


marginTop : String -> Declaration
marginTop =
    I.Single identity "margin-top"


marginTopJ : List String -> Declaration
marginTopJ =
    I.Single identity "margin-top" << String.join " "


marginTrim : String -> Declaration
marginTrim =
    I.Single identity "margin-trim"


marginTrimJ : List String -> Declaration
marginTrimJ =
    I.Single identity "margin-trim" << String.join " "


marker : String -> Declaration
marker =
    I.Single identity "marker"


markerJ : List String -> Declaration
markerJ =
    I.Single identity "marker" << String.join " "


markerEnd : String -> Declaration
markerEnd =
    I.Single identity "marker-end"


markerEndJ : List String -> Declaration
markerEndJ =
    I.Single identity "marker-end" << String.join " "


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


markerMid : String -> Declaration
markerMid =
    I.Single identity "marker-mid"


markerMidJ : List String -> Declaration
markerMidJ =
    I.Single identity "marker-mid" << String.join " "


markerPattern : String -> Declaration
markerPattern =
    I.Single identity "marker-pattern"


markerPatternJ : List String -> Declaration
markerPatternJ =
    I.Single identity "marker-pattern" << String.join " "


markerSegment : String -> Declaration
markerSegment =
    I.Single identity "marker-segment"


markerSegmentJ : List String -> Declaration
markerSegmentJ =
    I.Single identity "marker-segment" << String.join " "


markerSide : String -> Declaration
markerSide =
    I.Single identity "marker-side"


markerSideJ : List String -> Declaration
markerSideJ =
    I.Single identity "marker-side" << String.join " "


markerStart : String -> Declaration
markerStart =
    I.Single identity "marker-start"


markerStartJ : List String -> Declaration
markerStartJ =
    I.Single identity "marker-start" << String.join " "


mask : String -> Declaration
mask =
    I.Single identity "mask"


maskJ : List String -> Declaration
maskJ =
    I.Single identity "mask" << String.join " "


maskBorder : String -> Declaration
maskBorder =
    I.Single identity "mask-border"


maskBorderJ : List String -> Declaration
maskBorderJ =
    I.Single identity "mask-border" << String.join " "


maskBorderMode : String -> Declaration
maskBorderMode =
    I.Single identity "mask-border-mode"


maskBorderModeJ : List String -> Declaration
maskBorderModeJ =
    I.Single identity "mask-border-mode" << String.join " "


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


maskBorderSlice : String -> Declaration
maskBorderSlice =
    I.Single identity "mask-border-slice"


maskBorderSliceJ : List String -> Declaration
maskBorderSliceJ =
    I.Single identity "mask-border-slice" << String.join " "


maskBorderSource : String -> Declaration
maskBorderSource =
    I.Single identity "mask-border-source"


maskBorderSourceJ : List String -> Declaration
maskBorderSourceJ =
    I.Single identity "mask-border-source" << String.join " "


maskBorderWidth : String -> Declaration
maskBorderWidth =
    I.Single identity "mask-border-width"


maskBorderWidthJ : List String -> Declaration
maskBorderWidthJ =
    I.Single identity "mask-border-width" << String.join " "


maskClip : String -> Declaration
maskClip =
    I.Single identity "mask-clip"


maskClipJ : List String -> Declaration
maskClipJ =
    I.Single identity "mask-clip" << String.join " "


maskComposite : String -> Declaration
maskComposite =
    I.Single identity "mask-composite"


maskCompositeJ : List String -> Declaration
maskCompositeJ =
    I.Single identity "mask-composite" << String.join " "


maskImage : String -> Declaration
maskImage =
    I.Single identity "mask-image"


maskImageJ : List String -> Declaration
maskImageJ =
    I.Single identity "mask-image" << String.join " "


maskMode : String -> Declaration
maskMode =
    I.Single identity "mask-mode"


maskModeJ : List String -> Declaration
maskModeJ =
    I.Single identity "mask-mode" << String.join " "


maskOrigin : String -> Declaration
maskOrigin =
    I.Single identity "mask-origin"


maskOriginJ : List String -> Declaration
maskOriginJ =
    I.Single identity "mask-origin" << String.join " "


maskPosition : String -> Declaration
maskPosition =
    I.Single identity "mask-position"


maskPositionJ : List String -> Declaration
maskPositionJ =
    I.Single identity "mask-position" << String.join " "


maskRepeat : String -> Declaration
maskRepeat =
    I.Single identity "mask-repeat"


maskRepeatJ : List String -> Declaration
maskRepeatJ =
    I.Single identity "mask-repeat" << String.join " "


maskSize : String -> Declaration
maskSize =
    I.Single identity "mask-size"


maskSizeJ : List String -> Declaration
maskSizeJ =
    I.Single identity "mask-size" << String.join " "


maskType : String -> Declaration
maskType =
    I.Single identity "mask-type"


maskTypeJ : List String -> Declaration
maskTypeJ =
    I.Single identity "mask-type" << String.join " "


maxBlockSize : String -> Declaration
maxBlockSize =
    I.Single identity "max-block-size"


maxBlockSizeJ : List String -> Declaration
maxBlockSizeJ =
    I.Single identity "max-block-size" << String.join " "


maxHeight : String -> Declaration
maxHeight =
    I.Single identity "max-height"


maxHeightJ : List String -> Declaration
maxHeightJ =
    I.Single identity "max-height" << String.join " "


maxInlineSize : String -> Declaration
maxInlineSize =
    I.Single identity "max-inline-size"


maxInlineSizeJ : List String -> Declaration
maxInlineSizeJ =
    I.Single identity "max-inline-size" << String.join " "


maxLines : String -> Declaration
maxLines =
    I.Single identity "max-lines"


maxLinesJ : List String -> Declaration
maxLinesJ =
    I.Single identity "max-lines" << String.join " "


maxWidth : String -> Declaration
maxWidth =
    I.Single identity "max-width"


maxWidthJ : List String -> Declaration
maxWidthJ =
    I.Single identity "max-width" << String.join " "


minBlockSize : String -> Declaration
minBlockSize =
    I.Single identity "min-block-size"


minBlockSizeJ : List String -> Declaration
minBlockSizeJ =
    I.Single identity "min-block-size" << String.join " "


minHeight : String -> Declaration
minHeight =
    I.Single identity "min-height"


minHeightJ : List String -> Declaration
minHeightJ =
    I.Single identity "min-height" << String.join " "


minInlineSize : String -> Declaration
minInlineSize =
    I.Single identity "min-inline-size"


minInlineSizeJ : List String -> Declaration
minInlineSizeJ =
    I.Single identity "min-inline-size" << String.join " "


minWidth : String -> Declaration
minWidth =
    I.Single identity "min-width"


minWidthJ : List String -> Declaration
minWidthJ =
    I.Single identity "min-width" << String.join " "


mixBlendMode : String -> Declaration
mixBlendMode =
    I.Single identity "mix-blend-mode"


mixBlendModeJ : List String -> Declaration
mixBlendModeJ =
    I.Single identity "mix-blend-mode" << String.join " "


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


objectFit : String -> Declaration
objectFit =
    I.Single identity "object-fit"


objectFitJ : List String -> Declaration
objectFitJ =
    I.Single identity "object-fit" << String.join " "


objectPosition : String -> Declaration
objectPosition =
    I.Single identity "object-position"


objectPositionJ : List String -> Declaration
objectPositionJ =
    I.Single identity "object-position" << String.join " "


offset : String -> Declaration
offset =
    I.Single identity "offset"


offsetJ : List String -> Declaration
offsetJ =
    I.Single identity "offset" << String.join " "


offsetAfter : String -> Declaration
offsetAfter =
    I.Single identity "offset-after"


offsetAfterJ : List String -> Declaration
offsetAfterJ =
    I.Single identity "offset-after" << String.join " "


offsetAnchor : String -> Declaration
offsetAnchor =
    I.Single identity "offset-anchor"


offsetAnchorJ : List String -> Declaration
offsetAnchorJ =
    I.Single identity "offset-anchor" << String.join " "


offsetBefore : String -> Declaration
offsetBefore =
    I.Single identity "offset-before"


offsetBeforeJ : List String -> Declaration
offsetBeforeJ =
    I.Single identity "offset-before" << String.join " "


offsetDistance : String -> Declaration
offsetDistance =
    I.Single identity "offset-distance"


offsetDistanceJ : List String -> Declaration
offsetDistanceJ =
    I.Single identity "offset-distance" << String.join " "


offsetEnd : String -> Declaration
offsetEnd =
    I.Single identity "offset-end"


offsetEndJ : List String -> Declaration
offsetEndJ =
    I.Single identity "offset-end" << String.join " "


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


offsetRotate : String -> Declaration
offsetRotate =
    I.Single identity "offset-rotate"


offsetRotateJ : List String -> Declaration
offsetRotateJ =
    I.Single identity "offset-rotate" << String.join " "


offsetStart : String -> Declaration
offsetStart =
    I.Single identity "offset-start"


offsetStartJ : List String -> Declaration
offsetStartJ =
    I.Single identity "offset-start" << String.join " "


opacity : Float -> Declaration
opacity =
    I.Single identity "opacity" << String.fromFloat


order : String -> Declaration
order =
    I.Single identity "order"


orderJ : List String -> Declaration
orderJ =
    I.Single identity "order" << String.join " "


orphans : String -> Declaration
orphans =
    I.Single identity "orphans"


orphansJ : List String -> Declaration
orphansJ =
    I.Single identity "orphans" << String.join " "


outline : String -> Declaration
outline =
    I.Single identity "outline"


outlineJ : List String -> Declaration
outlineJ =
    I.Single identity "outline" << String.join " "


outlineColor : String -> Declaration
outlineColor =
    I.Single identity "outline-color"


outlineColorJ : List String -> Declaration
outlineColorJ =
    I.Single identity "outline-color" << String.join " "


outlineOffset : String -> Declaration
outlineOffset =
    I.Single identity "outline-offset"


outlineOffsetJ : List String -> Declaration
outlineOffsetJ =
    I.Single identity "outline-offset" << String.join " "


outlineStyle : String -> Declaration
outlineStyle =
    I.Single identity "outline-style"


outlineStyleJ : List String -> Declaration
outlineStyleJ =
    I.Single identity "outline-style" << String.join " "


outlineWidth : String -> Declaration
outlineWidth =
    I.Single identity "outline-width"


outlineWidthJ : List String -> Declaration
outlineWidthJ =
    I.Single identity "outline-width" << String.join " "


overflow : String -> Declaration
overflow =
    I.Single identity "overflow"


overflowJ : List String -> Declaration
overflowJ =
    I.Single identity "overflow" << String.join " "


overflowAnchor : String -> Declaration
overflowAnchor =
    I.Single identity "overflow-anchor"


overflowAnchorJ : List String -> Declaration
overflowAnchorJ =
    I.Single identity "overflow-anchor" << String.join " "


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


overflowWrap : String -> Declaration
overflowWrap =
    I.Single identity "overflow-wrap"


overflowWrapJ : List String -> Declaration
overflowWrapJ =
    I.Single identity "overflow-wrap" << String.join " "


overflowX : String -> Declaration
overflowX =
    I.Single identity "overflow-x"


overflowXJ : List String -> Declaration
overflowXJ =
    I.Single identity "overflow-x" << String.join " "


overflowY : String -> Declaration
overflowY =
    I.Single identity "overflow-y"


overflowYJ : List String -> Declaration
overflowYJ =
    I.Single identity "overflow-y" << String.join " "


overscrollBehavior : String -> Declaration
overscrollBehavior =
    I.Single identity "overscroll-behavior"


overscrollBehaviorJ : List String -> Declaration
overscrollBehaviorJ =
    I.Single identity "overscroll-behavior" << String.join " "


overscrollBehaviorBlock : String -> Declaration
overscrollBehaviorBlock =
    I.Single identity "overscroll-behavior-block"


overscrollBehaviorBlockJ : List String -> Declaration
overscrollBehaviorBlockJ =
    I.Single identity "overscroll-behavior-block" << String.join " "


overscrollBehaviorInline : String -> Declaration
overscrollBehaviorInline =
    I.Single identity "overscroll-behavior-inline"


overscrollBehaviorInlineJ : List String -> Declaration
overscrollBehaviorInlineJ =
    I.Single identity "overscroll-behavior-inline" << String.join " "


overscrollBehaviorX : String -> Declaration
overscrollBehaviorX =
    I.Single identity "overscroll-behavior-x"


overscrollBehaviorXJ : List String -> Declaration
overscrollBehaviorXJ =
    I.Single identity "overscroll-behavior-x" << String.join " "


overscrollBehaviorY : String -> Declaration
overscrollBehaviorY =
    I.Single identity "overscroll-behavior-y"


overscrollBehaviorYJ : List String -> Declaration
overscrollBehaviorYJ =
    I.Single identity "overscroll-behavior-y" << String.join " "


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


paddingBlockEnd : String -> Declaration
paddingBlockEnd =
    I.Single identity "padding-block-end"


paddingBlockEndJ : List String -> Declaration
paddingBlockEndJ =
    I.Single identity "padding-block-end" << String.join " "


paddingBlockStart : String -> Declaration
paddingBlockStart =
    I.Single identity "padding-block-start"


paddingBlockStartJ : List String -> Declaration
paddingBlockStartJ =
    I.Single identity "padding-block-start" << String.join " "


paddingBottom : String -> Declaration
paddingBottom =
    I.Single identity "padding-bottom"


paddingBottomJ : List String -> Declaration
paddingBottomJ =
    I.Single identity "padding-bottom" << String.join " "


paddingInline : String -> Declaration
paddingInline =
    I.Single identity "padding-inline"


paddingInlineJ : List String -> Declaration
paddingInlineJ =
    I.Single identity "padding-inline" << String.join " "


paddingInlineEnd : String -> Declaration
paddingInlineEnd =
    I.Single identity "padding-inline-end"


paddingInlineEndJ : List String -> Declaration
paddingInlineEndJ =
    I.Single identity "padding-inline-end" << String.join " "


paddingInlineStart : String -> Declaration
paddingInlineStart =
    I.Single identity "padding-inline-start"


paddingInlineStartJ : List String -> Declaration
paddingInlineStartJ =
    I.Single identity "padding-inline-start" << String.join " "


paddingLeft : String -> Declaration
paddingLeft =
    I.Single identity "padding-left"


paddingLeftJ : List String -> Declaration
paddingLeftJ =
    I.Single identity "padding-left" << String.join " "


paddingRight : String -> Declaration
paddingRight =
    I.Single identity "padding-right"


paddingRightJ : List String -> Declaration
paddingRightJ =
    I.Single identity "padding-right" << String.join " "


paddingTop : String -> Declaration
paddingTop =
    I.Single identity "padding-top"


paddingTopJ : List String -> Declaration
paddingTopJ =
    I.Single identity "padding-top" << String.join " "


page : String -> Declaration
page =
    I.Single identity "page"


pageJ : List String -> Declaration
pageJ =
    I.Single identity "page" << String.join " "


pageBreakAfter : String -> Declaration
pageBreakAfter =
    I.Single identity "page-break-after"


pageBreakAfterJ : List String -> Declaration
pageBreakAfterJ =
    I.Single identity "page-break-after" << String.join " "


pageBreakBefore : String -> Declaration
pageBreakBefore =
    I.Single identity "page-break-before"


pageBreakBeforeJ : List String -> Declaration
pageBreakBeforeJ =
    I.Single identity "page-break-before" << String.join " "


pageBreakInside : String -> Declaration
pageBreakInside =
    I.Single identity "page-break-inside"


pageBreakInsideJ : List String -> Declaration
pageBreakInsideJ =
    I.Single identity "page-break-inside" << String.join " "


pause : String -> Declaration
pause =
    I.Single identity "pause"


pauseJ : List String -> Declaration
pauseJ =
    I.Single identity "pause" << String.join " "


pauseAfter : String -> Declaration
pauseAfter =
    I.Single identity "pause-after"


pauseAfterJ : List String -> Declaration
pauseAfterJ =
    I.Single identity "pause-after" << String.join " "


pauseBefore : String -> Declaration
pauseBefore =
    I.Single identity "pause-before"


pauseBeforeJ : List String -> Declaration
pauseBeforeJ =
    I.Single identity "pause-before" << String.join " "


perspective : String -> Declaration
perspective =
    I.Single identity "perspective"


perspectiveJ : List String -> Declaration
perspectiveJ =
    I.Single identity "perspective" << String.join " "


perspectiveOrigin : String -> Declaration
perspectiveOrigin =
    I.Single identity "perspective-origin"


perspectiveOriginJ : List String -> Declaration
perspectiveOriginJ =
    I.Single identity "perspective-origin" << String.join " "


pitch : String -> Declaration
pitch =
    I.Single identity "pitch"


pitchJ : List String -> Declaration
pitchJ =
    I.Single identity "pitch" << String.join " "


pitchRange : String -> Declaration
pitchRange =
    I.Single identity "pitch-range"


pitchRangeJ : List String -> Declaration
pitchRangeJ =
    I.Single identity "pitch-range" << String.join " "


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


pointerEvents : String -> Declaration
pointerEvents =
    I.Single identity "pointer-events"


pointerEventsJ : List String -> Declaration
pointerEventsJ =
    I.Single identity "pointer-events" << String.join " "


position : String -> Declaration
position =
    I.Single identity "position"


positionJ : List String -> Declaration
positionJ =
    I.Single identity "position" << String.join " "


quotes : String -> Declaration
quotes =
    I.Single identity "quotes"


quotesJ : List String -> Declaration
quotesJ =
    I.Single identity "quotes" << String.join " "


regionFragment : String -> Declaration
regionFragment =
    I.Single identity "region-fragment"


regionFragmentJ : List String -> Declaration
regionFragmentJ =
    I.Single identity "region-fragment" << String.join " "


resize : String -> Declaration
resize =
    I.Single identity "resize"


resizeJ : List String -> Declaration
resizeJ =
    I.Single identity "resize" << String.join " "


rest : String -> Declaration
rest =
    I.Single identity "rest"


restJ : List String -> Declaration
restJ =
    I.Single identity "rest" << String.join " "


restAfter : String -> Declaration
restAfter =
    I.Single identity "rest-after"


restAfterJ : List String -> Declaration
restAfterJ =
    I.Single identity "rest-after" << String.join " "


restBefore : String -> Declaration
restBefore =
    I.Single identity "rest-before"


restBeforeJ : List String -> Declaration
restBeforeJ =
    I.Single identity "rest-before" << String.join " "


richness : String -> Declaration
richness =
    I.Single identity "richness"


richnessJ : List String -> Declaration
richnessJ =
    I.Single identity "richness" << String.join " "


right : String -> Declaration
right =
    I.Single identity "right"


rightJ : List String -> Declaration
rightJ =
    I.Single identity "right" << String.join " "


rotate : String -> Declaration
rotate =
    I.Single identity "rotate"


rotateJ : List String -> Declaration
rotateJ =
    I.Single identity "rotate" << String.join " "


rowGap : String -> Declaration
rowGap =
    I.Single identity "row-gap"


rowGapJ : List String -> Declaration
rowGapJ =
    I.Single identity "row-gap" << String.join " "


rubyAlign : String -> Declaration
rubyAlign =
    I.Single identity "ruby-align"


rubyAlignJ : List String -> Declaration
rubyAlignJ =
    I.Single identity "ruby-align" << String.join " "


rubyMerge : String -> Declaration
rubyMerge =
    I.Single identity "ruby-merge"


rubyMergeJ : List String -> Declaration
rubyMergeJ =
    I.Single identity "ruby-merge" << String.join " "


rubyPosition : String -> Declaration
rubyPosition =
    I.Single identity "ruby-position"


rubyPositionJ : List String -> Declaration
rubyPositionJ =
    I.Single identity "ruby-position" << String.join " "


running : String -> Declaration
running =
    I.Single identity "running"


runningJ : List String -> Declaration
runningJ =
    I.Single identity "running" << String.join " "


scale : String -> Declaration
scale =
    I.Single identity "scale"


scaleJ : List String -> Declaration
scaleJ =
    I.Single identity "scale" << String.join " "


scrollBehavior : String -> Declaration
scrollBehavior =
    I.Single identity "scroll-behavior"


scrollBehaviorJ : List String -> Declaration
scrollBehaviorJ =
    I.Single identity "scroll-behavior" << String.join " "


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


scrollMarginBlockEnd : String -> Declaration
scrollMarginBlockEnd =
    I.Single identity "scroll-margin-block-end"


scrollMarginBlockEndJ : List String -> Declaration
scrollMarginBlockEndJ =
    I.Single identity "scroll-margin-block-end" << String.join " "


scrollMarginBlockStart : String -> Declaration
scrollMarginBlockStart =
    I.Single identity "scroll-margin-block-start"


scrollMarginBlockStartJ : List String -> Declaration
scrollMarginBlockStartJ =
    I.Single identity "scroll-margin-block-start" << String.join " "


scrollMarginBottom : String -> Declaration
scrollMarginBottom =
    I.Single identity "scroll-margin-bottom"


scrollMarginBottomJ : List String -> Declaration
scrollMarginBottomJ =
    I.Single identity "scroll-margin-bottom" << String.join " "


scrollMarginInline : String -> Declaration
scrollMarginInline =
    I.Single identity "scroll-margin-inline"


scrollMarginInlineJ : List String -> Declaration
scrollMarginInlineJ =
    I.Single identity "scroll-margin-inline" << String.join " "


scrollMarginInlineEnd : String -> Declaration
scrollMarginInlineEnd =
    I.Single identity "scroll-margin-inline-end"


scrollMarginInlineEndJ : List String -> Declaration
scrollMarginInlineEndJ =
    I.Single identity "scroll-margin-inline-end" << String.join " "


scrollMarginInlineStart : String -> Declaration
scrollMarginInlineStart =
    I.Single identity "scroll-margin-inline-start"


scrollMarginInlineStartJ : List String -> Declaration
scrollMarginInlineStartJ =
    I.Single identity "scroll-margin-inline-start" << String.join " "


scrollMarginLeft : String -> Declaration
scrollMarginLeft =
    I.Single identity "scroll-margin-left"


scrollMarginLeftJ : List String -> Declaration
scrollMarginLeftJ =
    I.Single identity "scroll-margin-left" << String.join " "


scrollMarginRight : String -> Declaration
scrollMarginRight =
    I.Single identity "scroll-margin-right"


scrollMarginRightJ : List String -> Declaration
scrollMarginRightJ =
    I.Single identity "scroll-margin-right" << String.join " "


scrollMarginTop : String -> Declaration
scrollMarginTop =
    I.Single identity "scroll-margin-top"


scrollMarginTopJ : List String -> Declaration
scrollMarginTopJ =
    I.Single identity "scroll-margin-top" << String.join " "


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


scrollPaddingBlockEnd : String -> Declaration
scrollPaddingBlockEnd =
    I.Single identity "scroll-padding-block-end"


scrollPaddingBlockEndJ : List String -> Declaration
scrollPaddingBlockEndJ =
    I.Single identity "scroll-padding-block-end" << String.join " "


scrollPaddingBlockStart : String -> Declaration
scrollPaddingBlockStart =
    I.Single identity "scroll-padding-block-start"


scrollPaddingBlockStartJ : List String -> Declaration
scrollPaddingBlockStartJ =
    I.Single identity "scroll-padding-block-start" << String.join " "


scrollPaddingBottom : String -> Declaration
scrollPaddingBottom =
    I.Single identity "scroll-padding-bottom"


scrollPaddingBottomJ : List String -> Declaration
scrollPaddingBottomJ =
    I.Single identity "scroll-padding-bottom" << String.join " "


scrollPaddingInline : String -> Declaration
scrollPaddingInline =
    I.Single identity "scroll-padding-inline"


scrollPaddingInlineJ : List String -> Declaration
scrollPaddingInlineJ =
    I.Single identity "scroll-padding-inline" << String.join " "


scrollPaddingInlineEnd : String -> Declaration
scrollPaddingInlineEnd =
    I.Single identity "scroll-padding-inline-end"


scrollPaddingInlineEndJ : List String -> Declaration
scrollPaddingInlineEndJ =
    I.Single identity "scroll-padding-inline-end" << String.join " "


scrollPaddingInlineStart : String -> Declaration
scrollPaddingInlineStart =
    I.Single identity "scroll-padding-inline-start"


scrollPaddingInlineStartJ : List String -> Declaration
scrollPaddingInlineStartJ =
    I.Single identity "scroll-padding-inline-start" << String.join " "


scrollPaddingLeft : String -> Declaration
scrollPaddingLeft =
    I.Single identity "scroll-padding-left"


scrollPaddingLeftJ : List String -> Declaration
scrollPaddingLeftJ =
    I.Single identity "scroll-padding-left" << String.join " "


scrollPaddingRight : String -> Declaration
scrollPaddingRight =
    I.Single identity "scroll-padding-right"


scrollPaddingRightJ : List String -> Declaration
scrollPaddingRightJ =
    I.Single identity "scroll-padding-right" << String.join " "


scrollPaddingTop : String -> Declaration
scrollPaddingTop =
    I.Single identity "scroll-padding-top"


scrollPaddingTopJ : List String -> Declaration
scrollPaddingTopJ =
    I.Single identity "scroll-padding-top" << String.join " "


scrollSnapAlign : String -> Declaration
scrollSnapAlign =
    I.Single identity "scroll-snap-align"


scrollSnapAlignJ : List String -> Declaration
scrollSnapAlignJ =
    I.Single identity "scroll-snap-align" << String.join " "


scrollSnapStop : String -> Declaration
scrollSnapStop =
    I.Single identity "scroll-snap-stop"


scrollSnapStopJ : List String -> Declaration
scrollSnapStopJ =
    I.Single identity "scroll-snap-stop" << String.join " "


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


scrollbarWidth : String -> Declaration
scrollbarWidth =
    I.Single identity "scrollbar-width"


scrollbarWidthJ : List String -> Declaration
scrollbarWidthJ =
    I.Single identity "scrollbar-width" << String.join " "


shapeImageThreshold : String -> Declaration
shapeImageThreshold =
    I.Single identity "shape-image-threshold"


shapeImageThresholdJ : List String -> Declaration
shapeImageThresholdJ =
    I.Single identity "shape-image-threshold" << String.join " "


shapeInside : String -> Declaration
shapeInside =
    I.Single identity "shape-inside"


shapeInsideJ : List String -> Declaration
shapeInsideJ =
    I.Single identity "shape-inside" << String.join " "


shapeMargin : String -> Declaration
shapeMargin =
    I.Single identity "shape-margin"


shapeMarginJ : List String -> Declaration
shapeMarginJ =
    I.Single identity "shape-margin" << String.join " "


shapeOutside : String -> Declaration
shapeOutside =
    I.Single identity "shape-outside"


shapeOutsideJ : List String -> Declaration
shapeOutsideJ =
    I.Single identity "shape-outside" << String.join " "


spatialNavigationAction : String -> Declaration
spatialNavigationAction =
    I.Single identity "spatial-navigation-action"


spatialNavigationActionJ : List String -> Declaration
spatialNavigationActionJ =
    I.Single identity "spatial-navigation-action" << String.join " "


spatialNavigationContain : String -> Declaration
spatialNavigationContain =
    I.Single identity "spatial-navigation-contain"


spatialNavigationContainJ : List String -> Declaration
spatialNavigationContainJ =
    I.Single identity "spatial-navigation-contain" << String.join " "


spatialNavigationFunction : String -> Declaration
spatialNavigationFunction =
    I.Single identity "spatial-navigation-function"


spatialNavigationFunctionJ : List String -> Declaration
spatialNavigationFunctionJ =
    I.Single identity "spatial-navigation-function" << String.join " "


speak : String -> Declaration
speak =
    I.Single identity "speak"


speakJ : List String -> Declaration
speakJ =
    I.Single identity "speak" << String.join " "


speakAs : String -> Declaration
speakAs =
    I.Single identity "speak-as"


speakAsJ : List String -> Declaration
speakAsJ =
    I.Single identity "speak-as" << String.join " "


speakHeader : String -> Declaration
speakHeader =
    I.Single identity "speak-header"


speakHeaderJ : List String -> Declaration
speakHeaderJ =
    I.Single identity "speak-header" << String.join " "


speakNumeral : String -> Declaration
speakNumeral =
    I.Single identity "speak-numeral"


speakNumeralJ : List String -> Declaration
speakNumeralJ =
    I.Single identity "speak-numeral" << String.join " "


speakPunctuation : String -> Declaration
speakPunctuation =
    I.Single identity "speak-punctuation"


speakPunctuationJ : List String -> Declaration
speakPunctuationJ =
    I.Single identity "speak-punctuation" << String.join " "


speechRate : String -> Declaration
speechRate =
    I.Single identity "speech-rate"


speechRateJ : List String -> Declaration
speechRateJ =
    I.Single identity "speech-rate" << String.join " "


stress : String -> Declaration
stress =
    I.Single identity "stress"


stressJ : List String -> Declaration
stressJ =
    I.Single identity "stress" << String.join " "


stringSet : String -> Declaration
stringSet =
    I.Single identity "string-set"


stringSetJ : List String -> Declaration
stringSetJ =
    I.Single identity "string-set" << String.join " "


stroke : String -> Declaration
stroke =
    I.Single identity "stroke"


strokeJ : List String -> Declaration
strokeJ =
    I.Single identity "stroke" << String.join " "


strokeAlign : String -> Declaration
strokeAlign =
    I.Single identity "stroke-align"


strokeAlignJ : List String -> Declaration
strokeAlignJ =
    I.Single identity "stroke-align" << String.join " "


strokeAlignment : String -> Declaration
strokeAlignment =
    I.Single identity "stroke-alignment"


strokeAlignmentJ : List String -> Declaration
strokeAlignmentJ =
    I.Single identity "stroke-alignment" << String.join " "


strokeBreak : String -> Declaration
strokeBreak =
    I.Single identity "stroke-break"


strokeBreakJ : List String -> Declaration
strokeBreakJ =
    I.Single identity "stroke-break" << String.join " "


strokeColor : String -> Declaration
strokeColor =
    I.Single identity "stroke-color"


strokeColorJ : List String -> Declaration
strokeColorJ =
    I.Single identity "stroke-color" << String.join " "


strokeDashCorner : String -> Declaration
strokeDashCorner =
    I.Single identity "stroke-dash-corner"


strokeDashCornerJ : List String -> Declaration
strokeDashCornerJ =
    I.Single identity "stroke-dash-corner" << String.join " "


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


strokeDasharray : String -> Declaration
strokeDasharray =
    I.Single identity "stroke-dasharray"


strokeDasharrayJ : List String -> Declaration
strokeDasharrayJ =
    I.Single identity "stroke-dasharray" << String.join " "


strokeDashcorner : String -> Declaration
strokeDashcorner =
    I.Single identity "stroke-dashcorner"


strokeDashcornerJ : List String -> Declaration
strokeDashcornerJ =
    I.Single identity "stroke-dashcorner" << String.join " "


strokeDashoffset : String -> Declaration
strokeDashoffset =
    I.Single identity "stroke-dashoffset"


strokeDashoffsetJ : List String -> Declaration
strokeDashoffsetJ =
    I.Single identity "stroke-dashoffset" << String.join " "


strokeImage : String -> Declaration
strokeImage =
    I.Single identity "stroke-image"


strokeImageJ : List String -> Declaration
strokeImageJ =
    I.Single identity "stroke-image" << String.join " "


strokeLinecap : String -> Declaration
strokeLinecap =
    I.Single identity "stroke-linecap"


strokeLinecapJ : List String -> Declaration
strokeLinecapJ =
    I.Single identity "stroke-linecap" << String.join " "


strokeLinejoin : String -> Declaration
strokeLinejoin =
    I.Single identity "stroke-linejoin"


strokeLinejoinJ : List String -> Declaration
strokeLinejoinJ =
    I.Single identity "stroke-linejoin" << String.join " "


strokeMiterlimit : String -> Declaration
strokeMiterlimit =
    I.Single identity "stroke-miterlimit"


strokeMiterlimitJ : List String -> Declaration
strokeMiterlimitJ =
    I.Single identity "stroke-miterlimit" << String.join " "


strokeOpacity : String -> Declaration
strokeOpacity =
    I.Single identity "stroke-opacity"


strokeOpacityJ : List String -> Declaration
strokeOpacityJ =
    I.Single identity "stroke-opacity" << String.join " "


strokeOrigin : String -> Declaration
strokeOrigin =
    I.Single identity "stroke-origin"


strokeOriginJ : List String -> Declaration
strokeOriginJ =
    I.Single identity "stroke-origin" << String.join " "


strokePosition : String -> Declaration
strokePosition =
    I.Single identity "stroke-position"


strokePositionJ : List String -> Declaration
strokePositionJ =
    I.Single identity "stroke-position" << String.join " "


strokeRepeat : String -> Declaration
strokeRepeat =
    I.Single identity "stroke-repeat"


strokeRepeatJ : List String -> Declaration
strokeRepeatJ =
    I.Single identity "stroke-repeat" << String.join " "


strokeSize : String -> Declaration
strokeSize =
    I.Single identity "stroke-size"


strokeSizeJ : List String -> Declaration
strokeSizeJ =
    I.Single identity "stroke-size" << String.join " "


strokeWidth : String -> Declaration
strokeWidth =
    I.Single identity "stroke-width"


strokeWidthJ : List String -> Declaration
strokeWidthJ =
    I.Single identity "stroke-width" << String.join " "


tabSize : String -> Declaration
tabSize =
    I.Single identity "tab-size"


tabSizeJ : List String -> Declaration
tabSizeJ =
    I.Single identity "tab-size" << String.join " "


tableLayout : String -> Declaration
tableLayout =
    I.Single identity "table-layout"


tableLayoutJ : List String -> Declaration
tableLayoutJ =
    I.Single identity "table-layout" << String.join " "


textAlign : String -> Declaration
textAlign =
    I.Single identity "text-align"


textAlignJ : List String -> Declaration
textAlignJ =
    I.Single identity "text-align" << String.join " "


textAlignAll : String -> Declaration
textAlignAll =
    I.Single identity "text-align-all"


textAlignAllJ : List String -> Declaration
textAlignAllJ =
    I.Single identity "text-align-all" << String.join " "


textAlignLast : String -> Declaration
textAlignLast =
    I.Single identity "text-align-last"


textAlignLastJ : List String -> Declaration
textAlignLastJ =
    I.Single identity "text-align-last" << String.join " "


textCombineUpright : String -> Declaration
textCombineUpright =
    I.Single identity "text-combine-upright"


textCombineUprightJ : List String -> Declaration
textCombineUprightJ =
    I.Single identity "text-combine-upright" << String.join " "


textDecoration : String -> Declaration
textDecoration =
    I.Single identity "text-decoration"


textDecorationJ : List String -> Declaration
textDecorationJ =
    I.Single identity "text-decoration" << String.join " "


textDecorationColor : String -> Declaration
textDecorationColor =
    I.Single identity "text-decoration-color"


textDecorationColorJ : List String -> Declaration
textDecorationColorJ =
    I.Single identity "text-decoration-color" << String.join " "


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


textDecorationSkipInk : String -> Declaration
textDecorationSkipInk =
    I.Single identity "text-decoration-skip-ink"


textDecorationSkipInkJ : List String -> Declaration
textDecorationSkipInkJ =
    I.Single identity "text-decoration-skip-ink" << String.join " "


textDecorationStyle : String -> Declaration
textDecorationStyle =
    I.Single identity "text-decoration-style"


textDecorationStyleJ : List String -> Declaration
textDecorationStyleJ =
    I.Single identity "text-decoration-style" << String.join " "


textDecorationWidth : String -> Declaration
textDecorationWidth =
    I.Single identity "text-decoration-width"


textDecorationWidthJ : List String -> Declaration
textDecorationWidthJ =
    I.Single identity "text-decoration-width" << String.join " "


textEmphasis : String -> Declaration
textEmphasis =
    I.Single identity "text-emphasis"


textEmphasisJ : List String -> Declaration
textEmphasisJ =
    I.Single identity "text-emphasis" << String.join " "


textEmphasisColor : String -> Declaration
textEmphasisColor =
    I.Single identity "text-emphasis-color"


textEmphasisColorJ : List String -> Declaration
textEmphasisColorJ =
    I.Single identity "text-emphasis-color" << String.join " "


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


textGroupAlign : String -> Declaration
textGroupAlign =
    I.Single identity "text-group-align"


textGroupAlignJ : List String -> Declaration
textGroupAlignJ =
    I.Single identity "text-group-align" << String.join " "


textIndent : String -> Declaration
textIndent =
    I.Single identity "text-indent"


textIndentJ : List String -> Declaration
textIndentJ =
    I.Single identity "text-indent" << String.join " "


textJustify : String -> Declaration
textJustify =
    I.Single identity "text-justify"


textJustifyJ : List String -> Declaration
textJustifyJ =
    I.Single identity "text-justify" << String.join " "


textOrientation : String -> Declaration
textOrientation =
    I.Single identity "text-orientation"


textOrientationJ : List String -> Declaration
textOrientationJ =
    I.Single identity "text-orientation" << String.join " "


textOverflow : String -> Declaration
textOverflow =
    I.Single identity "text-overflow"


textOverflowJ : List String -> Declaration
textOverflowJ =
    I.Single identity "text-overflow" << String.join " "


textShadow : String -> Declaration
textShadow =
    I.Single identity "text-shadow"


textShadowJ : List String -> Declaration
textShadowJ =
    I.Single identity "text-shadow" << String.join " "


textSpaceCollapse : String -> Declaration
textSpaceCollapse =
    I.Single identity "text-space-collapse"


textSpaceCollapseJ : List String -> Declaration
textSpaceCollapseJ =
    I.Single identity "text-space-collapse" << String.join " "


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


textUnderlineOffset : String -> Declaration
textUnderlineOffset =
    I.Single identity "text-underline-offset"


textUnderlineOffsetJ : List String -> Declaration
textUnderlineOffsetJ =
    I.Single identity "text-underline-offset" << String.join " "


textUnderlinePosition : String -> Declaration
textUnderlinePosition =
    I.Single identity "text-underline-position"


textUnderlinePositionJ : List String -> Declaration
textUnderlinePositionJ =
    I.Single identity "text-underline-position" << String.join " "


textWrap : String -> Declaration
textWrap =
    I.Single identity "text-wrap"


textWrapJ : List String -> Declaration
textWrapJ =
    I.Single identity "text-wrap" << String.join " "


top : String -> Declaration
top =
    I.Single identity "top"


topJ : List String -> Declaration
topJ =
    I.Single identity "top" << String.join " "


transform : List String -> Declaration
transform =
    I.Single identity "transform" << String.join " "


transformJ : List (List String) -> Declaration
transformJ =
    I.Single identity "transform" << String.join " " << List.map (String.join "")


transformBox : String -> Declaration
transformBox =
    I.Single identity "transform-box"


transformBoxJ : List String -> Declaration
transformBoxJ =
    I.Single identity "transform-box" << String.join " "


transformOrigin : String -> Declaration
transformOrigin =
    I.Single identity "transform-origin"


transformOriginJ : List String -> Declaration
transformOriginJ =
    I.Single identity "transform-origin" << String.join " "


transformStyle : String -> Declaration
transformStyle =
    I.Single identity "transform-style"


transformStyleJ : List String -> Declaration
transformStyleJ =
    I.Single identity "transform-style" << String.join " "


transition : String -> Declaration
transition =
    I.Single identity "transition"


transitionJ : List String -> Declaration
transitionJ =
    I.Single identity "transition" << String.join " "


transitionDelay : String -> Declaration
transitionDelay =
    I.Single identity "transition-delay"


transitionDelayJ : List String -> Declaration
transitionDelayJ =
    I.Single identity "transition-delay" << String.join " "


transitionDuration : String -> Declaration
transitionDuration =
    I.Single identity "transition-duration"


transitionDurationJ : List String -> Declaration
transitionDurationJ =
    I.Single identity "transition-duration" << String.join " "


transitionProperty : String -> Declaration
transitionProperty =
    I.Single identity "transition-property"


transitionPropertyJ : List String -> Declaration
transitionPropertyJ =
    I.Single identity "transition-property" << String.join " "


transitionTimingFunction : String -> Declaration
transitionTimingFunction =
    I.Single identity "transition-timing-function"


transitionTimingFunctionJ : List String -> Declaration
transitionTimingFunctionJ =
    I.Single identity "transition-timing-function" << String.join " "


translate : String -> Declaration
translate =
    I.Single identity "translate"


translateJ : List String -> Declaration
translateJ =
    I.Single identity "translate" << String.join " "


unicodeBidi : String -> Declaration
unicodeBidi =
    I.Single identity "unicode-bidi"


unicodeBidiJ : List String -> Declaration
unicodeBidiJ =
    I.Single identity "unicode-bidi" << String.join " "


userSelect : String -> Declaration
userSelect =
    I.Single identity "user-select"


userSelectJ : List String -> Declaration
userSelectJ =
    I.Single identity "user-select" << String.join " "


verticalAlign : String -> Declaration
verticalAlign =
    I.Single identity "vertical-align"


verticalAlignJ : List String -> Declaration
verticalAlignJ =
    I.Single identity "vertical-align" << String.join " "


visibility : String -> Declaration
visibility =
    I.Single identity "visibility"


visibilityJ : List String -> Declaration
visibilityJ =
    I.Single identity "visibility" << String.join " "


voiceBalance : String -> Declaration
voiceBalance =
    I.Single identity "voice-balance"


voiceBalanceJ : List String -> Declaration
voiceBalanceJ =
    I.Single identity "voice-balance" << String.join " "


voiceDuration : String -> Declaration
voiceDuration =
    I.Single identity "voice-duration"


voiceDurationJ : List String -> Declaration
voiceDurationJ =
    I.Single identity "voice-duration" << String.join " "


voiceFamily : String -> Declaration
voiceFamily =
    I.Single identity "voice-family"


voiceFamilyJ : List String -> Declaration
voiceFamilyJ =
    I.Single identity "voice-family" << String.join " "


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


voiceStress : String -> Declaration
voiceStress =
    I.Single identity "voice-stress"


voiceStressJ : List String -> Declaration
voiceStressJ =
    I.Single identity "voice-stress" << String.join " "


voiceVolume : String -> Declaration
voiceVolume =
    I.Single identity "voice-volume"


voiceVolumeJ : List String -> Declaration
voiceVolumeJ =
    I.Single identity "voice-volume" << String.join " "


volume : String -> Declaration
volume =
    I.Single identity "volume"


volumeJ : List String -> Declaration
volumeJ =
    I.Single identity "volume" << String.join " "


whiteSpace : String -> Declaration
whiteSpace =
    I.Single identity "white-space"


whiteSpaceJ : List String -> Declaration
whiteSpaceJ =
    I.Single identity "white-space" << String.join " "


widows : String -> Declaration
widows =
    I.Single identity "widows"


widowsJ : List String -> Declaration
widowsJ =
    I.Single identity "widows" << String.join " "


width : String -> Declaration
width =
    I.Single identity "width"


widthJ : List String -> Declaration
widthJ =
    I.Single identity "width" << String.join " "


willChange : String -> Declaration
willChange =
    I.Single identity "will-change"


willChangeJ : List String -> Declaration
willChangeJ =
    I.Single identity "will-change" << String.join " "


wordBoundaryDetection : String -> Declaration
wordBoundaryDetection =
    I.Single identity "word-boundary-detection"


wordBoundaryDetectionJ : List String -> Declaration
wordBoundaryDetectionJ =
    I.Single identity "word-boundary-detection" << String.join " "


wordBoundaryExpansion : String -> Declaration
wordBoundaryExpansion =
    I.Single identity "word-boundary-expansion"


wordBoundaryExpansionJ : List String -> Declaration
wordBoundaryExpansionJ =
    I.Single identity "word-boundary-expansion" << String.join " "


wordBreak : String -> Declaration
wordBreak =
    I.Single identity "word-break"


wordBreakJ : List String -> Declaration
wordBreakJ =
    I.Single identity "word-break" << String.join " "


wordSpacing : String -> Declaration
wordSpacing =
    I.Single identity "word-spacing"


wordSpacingJ : List String -> Declaration
wordSpacingJ =
    I.Single identity "word-spacing" << String.join " "


wordWrap : String -> Declaration
wordWrap =
    I.Single identity "word-wrap"


wordWrapJ : List String -> Declaration
wordWrapJ =
    I.Single identity "word-wrap" << String.join " "


wrapAfter : String -> Declaration
wrapAfter =
    I.Single identity "wrap-after"


wrapAfterJ : List String -> Declaration
wrapAfterJ =
    I.Single identity "wrap-after" << String.join " "


wrapBefore : String -> Declaration
wrapBefore =
    I.Single identity "wrap-before"


wrapBeforeJ : List String -> Declaration
wrapBeforeJ =
    I.Single identity "wrap-before" << String.join " "


wrapFlow : String -> Declaration
wrapFlow =
    I.Single identity "wrap-flow"


wrapFlowJ : List String -> Declaration
wrapFlowJ =
    I.Single identity "wrap-flow" << String.join " "


wrapInside : String -> Declaration
wrapInside =
    I.Single identity "wrap-inside"


wrapInsideJ : List String -> Declaration
wrapInsideJ =
    I.Single identity "wrap-inside" << String.join " "


wrapThrough : String -> Declaration
wrapThrough =
    I.Single identity "wrap-through"


wrapThroughJ : List String -> Declaration
wrapThroughJ =
    I.Single identity "wrap-through" << String.join " "


writingMode : String -> Declaration
writingMode =
    I.Single identity "writing-mode"


writingModeJ : List String -> Declaration
writingModeJ =
    I.Single identity "writing-mode" << String.join " "


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
