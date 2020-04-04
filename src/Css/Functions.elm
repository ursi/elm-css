module Css.Functions exposing (..)

import Css.Internal exposing (function, function2, function3, function4, functionJ)



-- transform


matrix : String -> String
matrix =
    function "matrix"


translate : String -> String
translate =
    function "translate"


translateX : String -> String
translateX =
    function "translateX"


translateY : String -> String
translateY =
    function "translateY"


scale : String -> String
scale =
    function "scale"


scaleX : String -> String
scaleX =
    function "scaleX"


scaleY : String -> String
scaleY =
    function "scaleY"


rotate : String -> String
rotate =
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



-- color


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



-- filter


blur : String -> String
blur =
    function "blur"


brightness : String -> String
brightness =
    function "brightness"


contrast : String -> String
contrast =
    function "contrast"


dropShadow : String -> String
dropShadow =
    function "drop-shadow"


dropShadowJ : List String -> String
dropShadowJ =
    functionJ "drop-shadow"


grayscale : String -> String
grayscale =
    function "grayscale"


hueRotate : String -> String
hueRotate =
    function "hue-rotate"


invert : String -> String
invert =
    function "invert"


opacity : String -> String
opacity =
    function "opacity"


sepia : String -> String
sepia =
    function "sepia"


saturate : String -> String
saturate =
    function "saturate"



-- calc


calc : String -> String
calc =
    function "calc"


biOperator : String -> String -> String -> String
biOperator operator operand1 operand2 =
    "(" ++ operand1 ++ " " ++ operator ++ " " ++ operand2 ++ ")"


neg : String -> String
neg =
    (++) "-"


add : String -> String -> String
add =
    biOperator "+"


sub : String -> String -> String
sub =
    biOperator "-"


mul : Float -> String -> String
mul =
    biOperator "*" << String.fromFloat


div : String -> Float -> String
div value =
    biOperator "/" value << String.fromFloat



-- misc


url : String -> String
url url_ =
    "url('" ++ url_ ++ "')"
