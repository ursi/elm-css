module Css.Functions exposing (..)


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



-- misc


url : String -> String
url url_ =
    "url('" ++ url_ ++ "')"
