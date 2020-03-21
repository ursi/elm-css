module Css.Global exposing (..)

import Css as C exposing (Declaration)
import Css.Internal as I exposing (Declaration(..))
import Dict exposing (Dict)
import Murmur3
import VirtualDom as V exposing (Node)


todo =
    Debug.todo ""


type Statement
    = Rule String (List Declaration)
    | Batch (List Statement)
    | Import (List String)


type Stylesheet
    = Stylesheet Stylesheet_


type alias Stylesheet_ =
    { imports : List String
    , rules : Dict String (List Declaration)
    }


rule : String -> List Declaration -> Statement
rule =
    Rule


toStyleElement : List Statement -> List ( String, Node msg ) -> Node msg
toStyleElement statements styleTextNodes =
    V.keyedNode "style" [] <|
        toTextNodes statements
            ++ styleTextNodes


toTextNodes : List Statement -> List ( String, Node msg )
toTextNodes statements =
    toTextNodesFrom statements <| Stylesheet_ [] Dict.empty


toTextNodesFrom : List Statement -> Stylesheet_ -> List ( String, Node msg )
toTextNodesFrom statements stylesheet =
    case statements of
        first :: rest_ ->
            case first of
                Rule selector_ declarations ->
                    toTextNodesFrom rest_
                        { stylesheet
                            | rules =
                                Dict.get selector_ stylesheet.rules
                                    |> Maybe.map ((++) declarations)
                                    |> Maybe.withDefault declarations
                                    |> Dict.insert selector_
                                    >> (|>) stylesheet.rules
                        }

                Batch batchedStatements ->
                    toTextNodesFrom (batchedStatements ++ rest_) stylesheet

                Import imports_ ->
                    toTextNodesFrom rest_ { stylesheet | imports = imports_ }

        [] ->
            stylesheet.imports
                |> List.map (\import_ -> "@import '" ++ import_ ++ "';")
                |> String.join "\n"
                |> Tuple.pair "imports"
                << V.text
                |> (::)
                >> (|>) (rulesToTextNodes stylesheet.rules)


rulesToTextNodes : Dict String (List Declaration) -> List ( String, Node msg )
rulesToTextNodes =
    Dict.toList
        >> List.map
            (\( selector_, declarations ) ->
                declarations
                    |> (C.createSelectorVariation <| \_ -> selector_)
                    |> List.singleton
                    |> I.toString
                    |> Maybe.withDefault ""
                    |> (\text ->
                            ( String.fromInt <| Murmur3.hashString 0 text
                            , V.text text
                            )
                       )
            )


batch : List Statement -> Statement
batch =
    Batch


imports : List String -> Statement
imports =
    Import



-- Selectors


a : List Declaration -> Statement
a =
    Rule "a"


abbr : List Declaration -> Statement
abbr =
    Rule "abbr"


address : List Declaration -> Statement
address =
    Rule "address"


area : List Declaration -> Statement
area =
    Rule "area"


article : List Declaration -> Statement
article =
    Rule "article"


aside : List Declaration -> Statement
aside =
    Rule "aside"


audio : List Declaration -> Statement
audio =
    Rule "audio"


b : List Declaration -> Statement
b =
    Rule "b"


base : List Declaration -> Statement
base =
    Rule "base"


bdi : List Declaration -> Statement
bdi =
    Rule "bdi"


bdo : List Declaration -> Statement
bdo =
    Rule "bdo"


blockquote : List Declaration -> Statement
blockquote =
    Rule "blockquote"


body : List Declaration -> Statement
body =
    Rule "body"


br : List Declaration -> Statement
br =
    Rule "br"


button : List Declaration -> Statement
button =
    Rule "button"


canvas : List Declaration -> Statement
canvas =
    Rule "canvas"


caption : List Declaration -> Statement
caption =
    Rule "caption"


cite : List Declaration -> Statement
cite =
    Rule "cite"


code : List Declaration -> Statement
code =
    Rule "code"


col : List Declaration -> Statement
col =
    Rule "col"


colgroup : List Declaration -> Statement
colgroup =
    Rule "colgroup"


data : List Declaration -> Statement
data =
    Rule "data"


datalist : List Declaration -> Statement
datalist =
    Rule "datalist"


dd : List Declaration -> Statement
dd =
    Rule "dd"


del : List Declaration -> Statement
del =
    Rule "del"


details : List Declaration -> Statement
details =
    Rule "details"


dfn : List Declaration -> Statement
dfn =
    Rule "dfn"


dialog : List Declaration -> Statement
dialog =
    Rule "dialog"


div : List Declaration -> Statement
div =
    Rule "div"


dl : List Declaration -> Statement
dl =
    Rule "dl"


dt : List Declaration -> Statement
dt =
    Rule "dt"


em_ : List Declaration -> Statement
em_ =
    Rule "em"


embed : List Declaration -> Statement
embed =
    Rule "embed"


fieldset : List Declaration -> Statement
fieldset =
    Rule "fieldset"


figcaption : List Declaration -> Statement
figcaption =
    Rule "figcaption"


figure : List Declaration -> Statement
figure =
    Rule "figure"


footer : List Declaration -> Statement
footer =
    Rule "footer"


form : List Declaration -> Statement
form =
    Rule "form"


h1 : List Declaration -> Statement
h1 =
    Rule "h1"


head : List Declaration -> Statement
head =
    Rule "head"


header : List Declaration -> Statement
header =
    Rule "header"


hgroup : List Declaration -> Statement
hgroup =
    Rule "hgroup"


hr : List Declaration -> Statement
hr =
    Rule "hr"


html : List Declaration -> Statement
html =
    Rule "html"


i : List Declaration -> Statement
i =
    Rule "i"


iframe : List Declaration -> Statement
iframe =
    Rule "iframe"


img : List Declaration -> Statement
img =
    Rule "img"


input : List Declaration -> Statement
input =
    Rule "input"


ins : List Declaration -> Statement
ins =
    Rule "ins"


kbd : List Declaration -> Statement
kbd =
    Rule "kbd"


label : List Declaration -> Statement
label =
    Rule "label"


legend : List Declaration -> Statement
legend =
    Rule "legend"


li : List Declaration -> Statement
li =
    Rule "li"


link : List Declaration -> Statement
link =
    Rule "link"


main_ : List Declaration -> Statement
main_ =
    Rule "main"


map : List Declaration -> Statement
map =
    Rule "map"


mark : List Declaration -> Statement
mark =
    Rule "mark"


mathML : List Declaration -> Statement
mathML =
    Rule "MathML"


menu : List Declaration -> Statement
menu =
    Rule "menu"


meta : List Declaration -> Statement
meta =
    Rule "meta"


meter : List Declaration -> Statement
meter =
    Rule "meter"


nav : List Declaration -> Statement
nav =
    Rule "nav"


noscript : List Declaration -> Statement
noscript =
    Rule "noscript"


object : List Declaration -> Statement
object =
    Rule "object"


ol : List Declaration -> Statement
ol =
    Rule "ol"


optgroup : List Declaration -> Statement
optgroup =
    Rule "optgroup"


option : List Declaration -> Statement
option =
    Rule "option"


output : List Declaration -> Statement
output =
    Rule "output"


p : List Declaration -> Statement
p =
    Rule "p"


param : List Declaration -> Statement
param =
    Rule "param"


picture : List Declaration -> Statement
picture =
    Rule "picture"


pre : List Declaration -> Statement
pre =
    Rule "pre"


progress : List Declaration -> Statement
progress =
    Rule "progress"


q_ : List Declaration -> Statement
q_ =
    Rule "q"


rp : List Declaration -> Statement
rp =
    Rule "rp"


rt : List Declaration -> Statement
rt =
    Rule "rt"


ruby : List Declaration -> Statement
ruby =
    Rule "ruby"


s_ : List Declaration -> Statement
s_ =
    Rule "s"


samp : List Declaration -> Statement
samp =
    Rule "samp"


script : List Declaration -> Statement
script =
    Rule "script"


section : List Declaration -> Statement
section =
    Rule "section"


select : List Declaration -> Statement
select =
    Rule "select"


slot : List Declaration -> Statement
slot =
    Rule "slot"


small : List Declaration -> Statement
small =
    Rule "small"


source : List Declaration -> Statement
source =
    Rule "source"


span : List Declaration -> Statement
span =
    Rule "span"


strong : List Declaration -> Statement
strong =
    Rule "strong"


style : List Declaration -> Statement
style =
    Rule "style"


sub : List Declaration -> Statement
sub =
    Rule "sub"


summary : List Declaration -> Statement
summary =
    Rule "summary"


sup : List Declaration -> Statement
sup =
    Rule "sup"


svg : List Declaration -> Statement
svg =
    Rule "SVG"


table : List Declaration -> Statement
table =
    Rule "table"


tbody : List Declaration -> Statement
tbody =
    Rule "tbody"


td : List Declaration -> Statement
td =
    Rule "td"


template : List Declaration -> Statement
template =
    Rule "template"


textarea : List Declaration -> Statement
textarea =
    Rule "textarea"


tfoot : List Declaration -> Statement
tfoot =
    Rule "tfoot"


th : List Declaration -> Statement
th =
    Rule "th"


thead : List Declaration -> Statement
thead =
    Rule "thead"


time : List Declaration -> Statement
time =
    Rule "time"


title : List Declaration -> Statement
title =
    Rule "title"


tr : List Declaration -> Statement
tr =
    Rule "tr"


track : List Declaration -> Statement
track =
    Rule "track"


u : List Declaration -> Statement
u =
    Rule "u"


ul : List Declaration -> Statement
ul =
    Rule "ul"


var : List Declaration -> Statement
var =
    Rule "var"


video : List Declaration -> Statement
video =
    Rule "video"


wbr : List Declaration -> Statement
wbr =
    Rule "wbr"
