module Css.Global exposing (..)

import Css as C exposing (Declaration)
import Css.Internal as I exposing (Declaration(..))
import Dict exposing (Dict)
import Murmur3
import VirtualDom as V exposing (Node)


todo =
    Debug.todo ""


type Statement
    = Rule Rule_
    | Batch (List Statement)
    | Import (List String)
    | Keyframes Keyframes_


type alias Rule_ =
    { selector : String
    , declarations : List Declaration
    }


type alias Keyframes_ =
    { name : String
    , rules : List Rule_
    }


type Stylesheet
    = Stylesheet Stylesheet_


type alias Stylesheet_ =
    { imports : List String
    , keyframes : List Keyframes_
    , rules : Dict String (List Declaration)
    }


style : List (Node msg) -> Node msg
style =
    V.node "style" []


rule : String -> List Declaration -> Statement
rule =
    (<<) Rule << Rule_


keyframes : String -> List ( String, List Declaration ) -> Statement
keyframes name rules =
    rules
        |> List.map
            (\( selector, declarations ) ->
                Rule_ selector declarations
            )
        |> Keyframes_ name
        |> Keyframes


toStyleNode : List Statement -> List ( String, Node msg ) -> Node msg
toStyleNode statements styleNodes =
    V.keyedNode "style" [] <|
        toStyleNodes statements
            ++ styleNodes


toStyleNodes : List Statement -> List ( String, Node msg )
toStyleNodes statements =
    toStyleNodesFrom statements <| Stylesheet_ [] [] Dict.empty


toStyleNodesFrom : List Statement -> Stylesheet_ -> List ( String, Node msg )
toStyleNodesFrom statements stylesheet =
    case statements of
        first :: rest_ ->
            case first of
                Rule rule_ ->
                    toStyleNodesFrom rest_
                        { stylesheet
                            | rules =
                                Dict.get rule_.selector stylesheet.rules
                                    |> Maybe.map ((++) rule_.declarations)
                                    |> Maybe.withDefault rule_.declarations
                                    |> Dict.insert rule_.selector
                                    >> (|>) stylesheet.rules
                        }

                Batch batchedStatements ->
                    toStyleNodesFrom (batchedStatements ++ rest_) stylesheet

                Import imports_ ->
                    toStyleNodesFrom rest_ { stylesheet | imports = imports_ }

                Keyframes keyframes_ ->
                    toStyleNodesFrom rest_ { stylesheet | keyframes = keyframes_ :: stylesheet.keyframes }

        [] ->
            (if List.isEmpty stylesheet.imports then
                identity

             else
                (::)
                    (stylesheet.imports
                        |> I.joinMap
                            (\import_ -> "@import '" ++ import_ ++ "';")
                            "\n"
                        |> V.text
                        |> List.singleton
                        |> style
                        >> Tuple.pair "imports"
                    )
            )
                (keyframesToStyleNodes stylesheet.keyframes
                    ++ rulesToStyleNodes stylesheet.rules
                )


keyframesToStyleNodes : List Keyframes_ -> List ( String, Node msg )
keyframesToStyleNodes =
    List.map
        (\{ name, rules } ->
            ( "keyframes" ++ name
            , style <|
                [ V.text <|
                    "@keyframes "
                        ++ name
                        ++ " {\n"
                        ++ I.joinMap
                            (\{ selector, declarations } ->
                                ruleToString selector declarations
                            )
                            "\n"
                            rules
                        ++ "\n}"
                ]
            )
        )


rulesToStyleNodes : Dict String (List Declaration) -> List ( String, Node msg )
rulesToStyleNodes =
    Dict.toList
        >> List.map
            (\( selector, declarations ) ->
                let
                    ruleText =
                        ruleToString selector declarations
                in
                ( String.fromInt <| Murmur3.hashString I.seed ruleText
                , style [ V.text ruleText ]
                )
            )


ruleToString : String -> List Declaration -> String
ruleToString selector declarations =
    declarations
        |> (C.createSelectorVariation <| \_ -> selector)
        |> List.singleton
        |> I.toString
        |> Maybe.withDefault ""


batch : List Statement -> Statement
batch =
    Batch


imports : List String -> Statement
imports =
    Import



-- Selectors


a : List Declaration -> Statement
a =
    Rule << Rule_ "a"


abbr : List Declaration -> Statement
abbr =
    Rule << Rule_ "abbr"


address : List Declaration -> Statement
address =
    Rule << Rule_ "address"


area : List Declaration -> Statement
area =
    Rule << Rule_ "area"


article : List Declaration -> Statement
article =
    Rule << Rule_ "article"


aside : List Declaration -> Statement
aside =
    Rule << Rule_ "aside"


audio : List Declaration -> Statement
audio =
    Rule << Rule_ "audio"


b : List Declaration -> Statement
b =
    Rule << Rule_ "b"


base : List Declaration -> Statement
base =
    Rule << Rule_ "base"


bdi : List Declaration -> Statement
bdi =
    Rule << Rule_ "bdi"


bdo : List Declaration -> Statement
bdo =
    Rule << Rule_ "bdo"


blockquote : List Declaration -> Statement
blockquote =
    Rule << Rule_ "blockquote"


body : List Declaration -> Statement
body =
    Rule << Rule_ "body"


br : List Declaration -> Statement
br =
    Rule << Rule_ "br"


button : List Declaration -> Statement
button =
    Rule << Rule_ "button"


canvas : List Declaration -> Statement
canvas =
    Rule << Rule_ "canvas"


caption : List Declaration -> Statement
caption =
    Rule << Rule_ "caption"


cite : List Declaration -> Statement
cite =
    Rule << Rule_ "cite"


code : List Declaration -> Statement
code =
    Rule << Rule_ "code"


col : List Declaration -> Statement
col =
    Rule << Rule_ "col"


colgroup : List Declaration -> Statement
colgroup =
    Rule << Rule_ "colgroup"


data : List Declaration -> Statement
data =
    Rule << Rule_ "data"


datalist : List Declaration -> Statement
datalist =
    Rule << Rule_ "datalist"


dd : List Declaration -> Statement
dd =
    Rule << Rule_ "dd"


del : List Declaration -> Statement
del =
    Rule << Rule_ "del"


details : List Declaration -> Statement
details =
    Rule << Rule_ "details"


dfn : List Declaration -> Statement
dfn =
    Rule << Rule_ "dfn"


dialog : List Declaration -> Statement
dialog =
    Rule << Rule_ "dialog"


div : List Declaration -> Statement
div =
    Rule << Rule_ "div"


dl : List Declaration -> Statement
dl =
    Rule << Rule_ "dl"


dt : List Declaration -> Statement
dt =
    Rule << Rule_ "dt"


em_ : List Declaration -> Statement
em_ =
    Rule << Rule_ "em"


embed : List Declaration -> Statement
embed =
    Rule << Rule_ "embed"


fieldset : List Declaration -> Statement
fieldset =
    Rule << Rule_ "fieldset"


figcaption : List Declaration -> Statement
figcaption =
    Rule << Rule_ "figcaption"


figure : List Declaration -> Statement
figure =
    Rule << Rule_ "figure"


footer : List Declaration -> Statement
footer =
    Rule << Rule_ "footer"


form : List Declaration -> Statement
form =
    Rule << Rule_ "form"


h1 : List Declaration -> Statement
h1 =
    Rule << Rule_ "h1"


head : List Declaration -> Statement
head =
    Rule << Rule_ "head"


header : List Declaration -> Statement
header =
    Rule << Rule_ "header"


hgroup : List Declaration -> Statement
hgroup =
    Rule << Rule_ "hgroup"


hr : List Declaration -> Statement
hr =
    Rule << Rule_ "hr"


html : List Declaration -> Statement
html =
    Rule << Rule_ "html"


i : List Declaration -> Statement
i =
    Rule << Rule_ "i"


iframe : List Declaration -> Statement
iframe =
    Rule << Rule_ "iframe"


img : List Declaration -> Statement
img =
    Rule << Rule_ "img"


input : List Declaration -> Statement
input =
    Rule << Rule_ "input"


ins : List Declaration -> Statement
ins =
    Rule << Rule_ "ins"


kbd : List Declaration -> Statement
kbd =
    Rule << Rule_ "kbd"


label : List Declaration -> Statement
label =
    Rule << Rule_ "label"


legend : List Declaration -> Statement
legend =
    Rule << Rule_ "legend"


li : List Declaration -> Statement
li =
    Rule << Rule_ "li"


link : List Declaration -> Statement
link =
    Rule << Rule_ "link"


main_ : List Declaration -> Statement
main_ =
    Rule << Rule_ "main"


map : List Declaration -> Statement
map =
    Rule << Rule_ "map"


mark : List Declaration -> Statement
mark =
    Rule << Rule_ "mark"


mathML : List Declaration -> Statement
mathML =
    Rule << Rule_ "MathML"


menu : List Declaration -> Statement
menu =
    Rule << Rule_ "menu"


meta : List Declaration -> Statement
meta =
    Rule << Rule_ "meta"


meter : List Declaration -> Statement
meter =
    Rule << Rule_ "meter"


nav : List Declaration -> Statement
nav =
    Rule << Rule_ "nav"


noscript : List Declaration -> Statement
noscript =
    Rule << Rule_ "noscript"


object : List Declaration -> Statement
object =
    Rule << Rule_ "object"


ol : List Declaration -> Statement
ol =
    Rule << Rule_ "ol"


optgroup : List Declaration -> Statement
optgroup =
    Rule << Rule_ "optgroup"


option : List Declaration -> Statement
option =
    Rule << Rule_ "option"


output : List Declaration -> Statement
output =
    Rule << Rule_ "output"


p : List Declaration -> Statement
p =
    Rule << Rule_ "p"


param : List Declaration -> Statement
param =
    Rule << Rule_ "param"


picture : List Declaration -> Statement
picture =
    Rule << Rule_ "picture"


pre : List Declaration -> Statement
pre =
    Rule << Rule_ "pre"


progress : List Declaration -> Statement
progress =
    Rule << Rule_ "progress"


q_ : List Declaration -> Statement
q_ =
    Rule << Rule_ "q"


rp : List Declaration -> Statement
rp =
    Rule << Rule_ "rp"


rt : List Declaration -> Statement
rt =
    Rule << Rule_ "rt"


ruby : List Declaration -> Statement
ruby =
    Rule << Rule_ "ruby"


s_ : List Declaration -> Statement
s_ =
    Rule << Rule_ "s"


samp : List Declaration -> Statement
samp =
    Rule << Rule_ "samp"


script : List Declaration -> Statement
script =
    Rule << Rule_ "script"


section : List Declaration -> Statement
section =
    Rule << Rule_ "section"


select : List Declaration -> Statement
select =
    Rule << Rule_ "select"


slot : List Declaration -> Statement
slot =
    Rule << Rule_ "slot"


small : List Declaration -> Statement
small =
    Rule << Rule_ "small"


source : List Declaration -> Statement
source =
    Rule << Rule_ "source"


span : List Declaration -> Statement
span =
    Rule << Rule_ "span"


strong : List Declaration -> Statement
strong =
    Rule << Rule_ "strong"


sub : List Declaration -> Statement
sub =
    Rule << Rule_ "sub"


summary : List Declaration -> Statement
summary =
    Rule << Rule_ "summary"


sup : List Declaration -> Statement
sup =
    Rule << Rule_ "sup"


svg : List Declaration -> Statement
svg =
    Rule << Rule_ "SVG"


table : List Declaration -> Statement
table =
    Rule << Rule_ "table"


tbody : List Declaration -> Statement
tbody =
    Rule << Rule_ "tbody"


td : List Declaration -> Statement
td =
    Rule << Rule_ "td"


template : List Declaration -> Statement
template =
    Rule << Rule_ "template"


textarea : List Declaration -> Statement
textarea =
    Rule << Rule_ "textarea"


tfoot : List Declaration -> Statement
tfoot =
    Rule << Rule_ "tfoot"


th : List Declaration -> Statement
th =
    Rule << Rule_ "th"


thead : List Declaration -> Statement
thead =
    Rule << Rule_ "thead"


time : List Declaration -> Statement
time =
    Rule << Rule_ "time"


title : List Declaration -> Statement
title =
    Rule << Rule_ "title"


tr : List Declaration -> Statement
tr =
    Rule << Rule_ "tr"


track : List Declaration -> Statement
track =
    Rule << Rule_ "track"


u : List Declaration -> Statement
u =
    Rule << Rule_ "u"


ul : List Declaration -> Statement
ul =
    Rule << Rule_ "ul"


var : List Declaration -> Statement
var =
    Rule << Rule_ "var"


video : List Declaration -> Statement
video =
    Rule << Rule_ "video"


wbr : List Declaration -> Statement
wbr =
    Rule << Rule_ "wbr"
