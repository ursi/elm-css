module Css.Functions exposing
    ( matrix, translate, translateX, translateY, scale, scaleX, scaleY, rotate, skew, skewX, skewY
    , rgb, rgba, hls, hlsa
    , blur, brightness, contrast, dropShadow, dropShadowJ, grayscale, hueRotate, invert, opacity, sepia, saturate
    , calc, neg, add, sub, mul, div
    , url
    )

{-|


# [Transform](https://www.w3.org/TR/2019/CR-css-transforms-1-20190214/#transform-functions)

@docs matrix, translate, translateX, translateY, scale, scaleX, scaleY, rotate, skew, skewX, skewY


# [Color](https://www.w3.org/TR/css-color-3/#numerical)

@docs rgb, rgba, hls, hlsa


# [Filter](https://www.w3.org/TR/2018/WD-filter-effects-1-20181218/#filter-functions)

@docs blur, brightness, contrast, dropShadow, dropShadowJ, grayscale, hueRotate, invert, opacity, sepia, saturate


# [Calc](https://drafts.csswg.org/css-values-3/#calc-notation)

@docs calc, neg, add, sub, mul, div


# Misc.

@docs url

-}

import Css.Internal as I exposing (function, function2, function3, function4)



-- transform


{-| -}
matrix : List Float -> String
matrix m =
    m
        |> I.joinMap String.fromFloat ", "
        |> function "matrix"


{-| -}
translate : String -> String
translate =
    function "translate"


{-| -}
translateX : String -> String
translateX =
    function "translateX"


{-| -}
translateY : String -> String
translateY =
    function "translateY"


{-| -}
scale : Float -> Float -> String
scale x y =
    function2 "scale"
        (String.fromFloat x)
        (String.fromFloat y)


{-| -}
scaleX : Float -> String
scaleX =
    function "scaleX" << String.fromFloat


{-| -}
scaleY : Float -> String
scaleY =
    function "scaleY" << String.fromFloat


{-| -}
rotate : String -> String
rotate =
    function "rotate"


{-| -}
skew : String -> String
skew =
    function "skew"


{-| -}
skewX : String -> String
skewX =
    function "skewX"


{-| -}
skewY : String -> String
skewY =
    function "skewY"



-- color


{-| -}
rgb : String -> String -> String -> String
rgb =
    function3 "rgb"


{-| -}
rgba : String -> String -> String -> String -> String
rgba =
    function4 "rgba"


{-| -}
hls : String -> String -> String -> String
hls =
    function3 "hls"


{-| -}
hlsa : String -> String -> String -> String -> String
hlsa =
    function4 "hlsa"



-- filter


{-| -}
blur : String -> String
blur =
    function "blur"


{-| -}
brightness : String -> String
brightness =
    function "brightness"


{-| -}
contrast : String -> String
contrast =
    function "contrast"


{-| -}
dropShadow : String -> String
dropShadow =
    function "drop-shadow"


{-| -}
dropShadowJ : List String -> String
dropShadowJ =
    String.join " "
        >> function "drop-shadow"


{-| -}
grayscale : String -> String
grayscale =
    function "grayscale"


{-| -}
hueRotate : String -> String
hueRotate =
    function "hue-rotate"


{-| -}
invert : String -> String
invert =
    function "invert"


{-| -}
opacity : String -> String
opacity =
    function "opacity"


{-| -}
sepia : String -> String
sepia =
    function "sepia"


{-| -}
saturate : String -> String
saturate =
    function "saturate"



-- calc


{-| -}
calc : String -> String
calc =
    function "calc"


biOperator : String -> String -> String -> String
biOperator operator operand1 operand2 =
    "(" ++ operand1 ++ " " ++ operator ++ " " ++ operand2 ++ ")"


{-| -}
neg : String -> String
neg =
    (++) "-"


{-| -}
add : String -> String -> String
add =
    biOperator "+"


{-| -}
sub : String -> String -> String
sub =
    biOperator "-"


{-| -}
mul : Float -> String -> String
mul =
    biOperator "*" << String.fromFloat


{-| -}
div : String -> Float -> String
div value =
    biOperator "/" value << String.fromFloat



-- misc


{-| [spec](https://drafts.csswg.org/css-values-3/#urls)
-}
url : String -> String
url url_ =
    "url('" ++ url_ ++ "')"
