module Html.Styled exposing (..)

import Css.Global as G exposing (Statement)
import Css.Internal as I exposing (Declaration)
import Dict exposing (Dict)
import Html.Attributes as A
import Murmur3
import VirtualDom as V
import VirtualDom.Styled as VS exposing (Node)


withStyles : List Statement -> List (Node msg) -> List (V.Node msg)
withStyles =
    VS.withStyles


toHtml : Node msg -> V.Node msg
toHtml =
    VS.toNode


fromHtml : V.Node msg -> Node msg
fromHtml =
    VS.VNode


toStyledNode :
    Maybe ( String, String )
    -> Maybe String
    -> String
    -> List (Attribute msg)
    -> List (Node msg)
    -> V.Node msg
toStyledNode =
    VS.toStyledNode


toStyledKeyedNode :
    Maybe ( String, String )
    -> Maybe String
    -> String
    -> List (Attribute msg)
    -> List ( String, Node msg )
    -> V.Node msg
toStyledKeyedNode =
    VS.toStyledKeyedNode


type alias Html msg =
    Node msg


type alias Attribute msg =
    V.Attribute msg


text : String -> Html msg
text =
    VS.VNode << V.text


node : String -> List (Attribute msg) -> List (Node msg) -> Node msg
node =
    VS.Node


nodeS : String -> List Declaration -> List (Attribute msg) -> List (Node msg) -> Node msg
nodeS =
    VS.StyledNode


map : (a -> msg) -> Node a -> Node msg
map =
    VS.map


h1 : List (Attribute msg) -> List (Html msg) -> Html msg
h1 =
    VS.Node "h1"


h1S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h1S =
    VS.StyledNode "h1"


h2 : List (Attribute msg) -> List (Html msg) -> Html msg
h2 =
    VS.Node "h2"


h2S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h2S =
    VS.StyledNode "h2"


h3 : List (Attribute msg) -> List (Html msg) -> Html msg
h3 =
    VS.Node "h3"


h3S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h3S =
    VS.StyledNode "h3"


h4 : List (Attribute msg) -> List (Html msg) -> Html msg
h4 =
    VS.Node "h4"


h4S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h4S =
    VS.StyledNode "h4"


h5 : List (Attribute msg) -> List (Html msg) -> Html msg
h5 =
    VS.Node "h5"


h5S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h5S =
    VS.StyledNode "h5"


h6 : List (Attribute msg) -> List (Html msg) -> Html msg
h6 =
    VS.Node "h6"


h6S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h6S =
    VS.StyledNode "h6"


div : List (Attribute msg) -> List (Html msg) -> Html msg
div =
    VS.Node "div"


divS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
divS =
    VS.StyledNode "div"


p : List (Attribute msg) -> List (Html msg) -> Html msg
p =
    VS.Node "p"


pS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
pS =
    VS.StyledNode "p"


hr : List (Attribute msg) -> List (Html msg) -> Html msg
hr =
    VS.Node "hr"


hrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
hrS =
    VS.StyledNode "hr"


pre : List (Attribute msg) -> List (Html msg) -> Html msg
pre =
    VS.Node "pre"


preS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
preS =
    VS.StyledNode "pre"


blockquote : List (Attribute msg) -> List (Html msg) -> Html msg
blockquote =
    VS.Node "blockquote"


blockquoteS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
blockquoteS =
    VS.StyledNode "blockquote"


span : List (Attribute msg) -> List (Html msg) -> Html msg
span =
    VS.Node "span"


spanS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
spanS =
    VS.StyledNode "span"


a : List (Attribute msg) -> List (Html msg) -> Html msg
a =
    VS.Node "a"


aS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
aS =
    VS.StyledNode "a"


code : List (Attribute msg) -> List (Html msg) -> Html msg
code =
    VS.Node "code"


codeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
codeS =
    VS.StyledNode "code"


em : List (Attribute msg) -> List (Html msg) -> Html msg
em =
    VS.Node "em"


emS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
emS =
    VS.StyledNode "em"


strong : List (Attribute msg) -> List (Html msg) -> Html msg
strong =
    VS.Node "strong"


strongS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
strongS =
    VS.StyledNode "strong"


i : List (Attribute msg) -> List (Html msg) -> Html msg
i =
    VS.Node "i"


iS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
iS =
    VS.StyledNode "i"


b : List (Attribute msg) -> List (Html msg) -> Html msg
b =
    VS.Node "b"


bS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bS =
    VS.StyledNode "b"


u : List (Attribute msg) -> List (Html msg) -> Html msg
u =
    VS.Node "u"


uS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
uS =
    VS.StyledNode "u"


sub : List (Attribute msg) -> List (Html msg) -> Html msg
sub =
    VS.Node "sub"


subS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
subS =
    VS.StyledNode "sub"


sup : List (Attribute msg) -> List (Html msg) -> Html msg
sup =
    VS.Node "sup"


supS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
supS =
    VS.StyledNode "sup"


br : List (Attribute msg) -> List (Html msg) -> Html msg
br =
    VS.Node "br"


brS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
brS =
    VS.StyledNode "br"


ol : List (Attribute msg) -> List (Html msg) -> Html msg
ol =
    VS.Node "ol"


olS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
olS =
    VS.StyledNode "ol"


ul : List (Attribute msg) -> List (Html msg) -> Html msg
ul =
    VS.Node "ul"


ulS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
ulS =
    VS.StyledNode "ul"


li : List (Attribute msg) -> List (Html msg) -> Html msg
li =
    VS.Node "li"


liS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
liS =
    VS.StyledNode "li"


dl : List (Attribute msg) -> List (Html msg) -> Html msg
dl =
    VS.Node "dl"


dlS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dlS =
    VS.StyledNode "dl"


dt : List (Attribute msg) -> List (Html msg) -> Html msg
dt =
    VS.Node "dt"


dtS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dtS =
    VS.StyledNode "dt"


dd : List (Attribute msg) -> List (Html msg) -> Html msg
dd =
    VS.Node "dd"


ddS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
ddS =
    VS.StyledNode "dd"


img : List (Attribute msg) -> List (Html msg) -> Html msg
img =
    VS.Node "img"


imgS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
imgS =
    VS.StyledNode "img"


iframe : List (Attribute msg) -> List (Html msg) -> Html msg
iframe =
    VS.Node "iframe"


iframeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
iframeS =
    VS.StyledNode "iframe"


canvas : List (Attribute msg) -> List (Html msg) -> Html msg
canvas =
    VS.Node "canvas"


canvasS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
canvasS =
    VS.StyledNode "canvas"


math : List (Attribute msg) -> List (Html msg) -> Html msg
math =
    VS.Node "math"


mathS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
mathS =
    VS.StyledNode "math"


form : List (Attribute msg) -> List (Html msg) -> Html msg
form =
    VS.Node "form"


formS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
formS =
    VS.StyledNode "form"


input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    VS.Node "input"


inputS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
inputS =
    VS.StyledNode "input"


textarea : List (Attribute msg) -> List (Html msg) -> Html msg
textarea =
    VS.Node "textarea"


textareaS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
textareaS =
    VS.StyledNode "textarea"


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    VS.Node "button"


buttonS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonS =
    VS.StyledNode "button"


select : List (Attribute msg) -> List (Html msg) -> Html msg
select =
    VS.Node "select"


selectS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
selectS =
    VS.StyledNode "select"


option : List (Attribute msg) -> List (Html msg) -> Html msg
option =
    VS.Node "option"


optionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
optionS =
    VS.StyledNode "option"


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    VS.Node "section"


sectionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sectionS =
    VS.StyledNode "section"


nav : List (Attribute msg) -> List (Html msg) -> Html msg
nav =
    VS.Node "nav"


navS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
navS =
    VS.StyledNode "nav"


article : List (Attribute msg) -> List (Html msg) -> Html msg
article =
    VS.Node "article"


articleS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
articleS =
    VS.StyledNode "article"


aside : List (Attribute msg) -> List (Html msg) -> Html msg
aside =
    VS.Node "aside"


asideS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
asideS =
    VS.StyledNode "aside"


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    VS.Node "header"


headerS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
headerS =
    VS.StyledNode "header"


footer : List (Attribute msg) -> List (Html msg) -> Html msg
footer =
    VS.Node "footer"


footerS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
footerS =
    VS.StyledNode "footer"


address : List (Attribute msg) -> List (Html msg) -> Html msg
address =
    VS.Node "address"


addressS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
addressS =
    VS.StyledNode "address"


main_ : List (Attribute msg) -> List (Html msg) -> Html msg
main_ =
    VS.Node "main"


mainS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
mainS =
    VS.StyledNode "main"


figure : List (Attribute msg) -> List (Html msg) -> Html msg
figure =
    VS.Node "figure"


figureS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
figureS =
    VS.StyledNode "figure"


figcaption : List (Attribute msg) -> List (Html msg) -> Html msg
figcaption =
    VS.Node "figcaption"


figcaptionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
figcaptionS =
    VS.StyledNode "figcaption"


table : List (Attribute msg) -> List (Html msg) -> Html msg
table =
    VS.Node "table"


tableS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tableS =
    VS.StyledNode "table"


caption : List (Attribute msg) -> List (Html msg) -> Html msg
caption =
    VS.Node "caption"


captionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
captionS =
    VS.StyledNode "caption"


colgroup : List (Attribute msg) -> List (Html msg) -> Html msg
colgroup =
    VS.Node "colgroup"


colgroupS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
colgroupS =
    VS.StyledNode "colgroup"


col : List (Attribute msg) -> List (Html msg) -> Html msg
col =
    VS.Node "col"


colS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
colS =
    VS.StyledNode "col"


tbody : List (Attribute msg) -> List (Html msg) -> Html msg
tbody =
    VS.Node "tbody"


tbodyS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tbodyS =
    VS.StyledNode "tbody"


thead : List (Attribute msg) -> List (Html msg) -> Html msg
thead =
    VS.Node "thead"


theadS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
theadS =
    VS.StyledNode "thead"


tfoot : List (Attribute msg) -> List (Html msg) -> Html msg
tfoot =
    VS.Node "tfoot"


tfootS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tfootS =
    VS.StyledNode "tfoot"


tr : List (Attribute msg) -> List (Html msg) -> Html msg
tr =
    VS.Node "tr"


trS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
trS =
    VS.StyledNode "tr"


td : List (Attribute msg) -> List (Html msg) -> Html msg
td =
    VS.Node "td"


tdS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tdS =
    VS.StyledNode "td"


th : List (Attribute msg) -> List (Html msg) -> Html msg
th =
    VS.Node "th"


thS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
thS =
    VS.StyledNode "th"


fieldset : List (Attribute msg) -> List (Html msg) -> Html msg
fieldset =
    VS.Node "fieldset"


fieldsetS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
fieldsetS =
    VS.StyledNode "fieldset"


legend : List (Attribute msg) -> List (Html msg) -> Html msg
legend =
    VS.Node "legend"


legendS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
legendS =
    VS.StyledNode "legend"


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    VS.Node "label"


labelS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
labelS =
    VS.StyledNode "label"


datalist : List (Attribute msg) -> List (Html msg) -> Html msg
datalist =
    VS.Node "datalist"


datalistS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
datalistS =
    VS.StyledNode "datalist"


optgroup : List (Attribute msg) -> List (Html msg) -> Html msg
optgroup =
    VS.Node "optgroup"


optgroupS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
optgroupS =
    VS.StyledNode "optgroup"


output : List (Attribute msg) -> List (Html msg) -> Html msg
output =
    VS.Node "output"


outputS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
outputS =
    VS.StyledNode "output"


progress : List (Attribute msg) -> List (Html msg) -> Html msg
progress =
    VS.Node "progress"


progressS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
progressS =
    VS.StyledNode "progress"


meter : List (Attribute msg) -> List (Html msg) -> Html msg
meter =
    VS.Node "meter"


meterS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
meterS =
    VS.StyledNode "meter"


audio : List (Attribute msg) -> List (Html msg) -> Html msg
audio =
    VS.Node "audio"


audioS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
audioS =
    VS.StyledNode "audio"


video : List (Attribute msg) -> List (Html msg) -> Html msg
video =
    VS.Node "video"


videoS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
videoS =
    VS.StyledNode "video"


source : List (Attribute msg) -> List (Html msg) -> Html msg
source =
    VS.Node "source"


sourceS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sourceS =
    VS.StyledNode "source"


track : List (Attribute msg) -> List (Html msg) -> Html msg
track =
    VS.Node "track"


trackS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
trackS =
    VS.StyledNode "track"


embed : List (Attribute msg) -> List (Html msg) -> Html msg
embed =
    VS.Node "embed"


embedS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
embedS =
    VS.StyledNode "embed"


object : List (Attribute msg) -> List (Html msg) -> Html msg
object =
    VS.Node "object"


objectS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
objectS =
    VS.StyledNode "object"


param : List (Attribute msg) -> List (Html msg) -> Html msg
param =
    VS.Node "param"


paramS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
paramS =
    VS.StyledNode "param"


ins : List (Attribute msg) -> List (Html msg) -> Html msg
ins =
    VS.Node "ins"


insS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
insS =
    VS.StyledNode "ins"


del : List (Attribute msg) -> List (Html msg) -> Html msg
del =
    VS.Node "del"


delS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
delS =
    VS.StyledNode "del"


small : List (Attribute msg) -> List (Html msg) -> Html msg
small =
    VS.Node "small"


smallS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
smallS =
    VS.StyledNode "small"


cite : List (Attribute msg) -> List (Html msg) -> Html msg
cite =
    VS.Node "cite"


citeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
citeS =
    VS.StyledNode "cite"


dfn : List (Attribute msg) -> List (Html msg) -> Html msg
dfn =
    VS.Node "dfn"


dfnS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dfnS =
    VS.StyledNode "dfn"


abbr : List (Attribute msg) -> List (Html msg) -> Html msg
abbr =
    VS.Node "abbr"


abbrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
abbrS =
    VS.StyledNode "abbr"


time : List (Attribute msg) -> List (Html msg) -> Html msg
time =
    VS.Node "time"


timeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
timeS =
    VS.StyledNode "time"


var : List (Attribute msg) -> List (Html msg) -> Html msg
var =
    VS.Node "var"


varS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
varS =
    VS.StyledNode "var"


samp : List (Attribute msg) -> List (Html msg) -> Html msg
samp =
    VS.Node "samp"


sampS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sampS =
    VS.StyledNode "samp"


kbd : List (Attribute msg) -> List (Html msg) -> Html msg
kbd =
    VS.Node "kbd"


kbdS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
kbdS =
    VS.StyledNode "kbd"


s : List (Attribute msg) -> List (Html msg) -> Html msg
s =
    VS.Node "s"


sS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sS =
    VS.StyledNode "s"


q : List (Attribute msg) -> List (Html msg) -> Html msg
q =
    VS.Node "q"


qS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
qS =
    VS.StyledNode "q"


mark : List (Attribute msg) -> List (Html msg) -> Html msg
mark =
    VS.Node "mark"


markS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
markS =
    VS.StyledNode "mark"


ruby : List (Attribute msg) -> List (Html msg) -> Html msg
ruby =
    VS.Node "ruby"


rubyS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rubyS =
    VS.StyledNode "ruby"


rt : List (Attribute msg) -> List (Html msg) -> Html msg
rt =
    VS.Node "rt"


rtS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rtS =
    VS.StyledNode "rt"


rp : List (Attribute msg) -> List (Html msg) -> Html msg
rp =
    VS.Node "rp"


rpS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rpS =
    VS.StyledNode "rp"


bdi : List (Attribute msg) -> List (Html msg) -> Html msg
bdi =
    VS.Node "bdi"


bdiS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bdiS =
    VS.StyledNode "bdi"


bdo : List (Attribute msg) -> List (Html msg) -> Html msg
bdo =
    VS.Node "bdo"


bdoS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bdoS =
    VS.StyledNode "bdo"


wbr : List (Attribute msg) -> List (Html msg) -> Html msg
wbr =
    VS.Node "wbr"


wbrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
wbrS =
    VS.StyledNode "wbr"


details : List (Attribute msg) -> List (Html msg) -> Html msg
details =
    VS.Node "details"


detailsS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
detailsS =
    VS.StyledNode "details"


summary : List (Attribute msg) -> List (Html msg) -> Html msg
summary =
    VS.Node "summary"


summaryS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
summaryS =
    VS.StyledNode "summary"


menuitem : List (Attribute msg) -> List (Html msg) -> Html msg
menuitem =
    VS.Node "menuitem"


menuitemS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
menuitemS =
    VS.StyledNode "menuitem"


menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu =
    VS.Node "menu"


menuS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
menuS =
    VS.StyledNode "menu"
