module Html.Styled exposing (..)

import Css.Global as G exposing (Statement)
import Css.Internal as I exposing (Declaration)
import Dict exposing (Dict)
import Html.Attributes as A
import Murmur3 as M
import VirtualDom as V


type Node msg
    = Text String
    | Node String (List (Attribute msg)) (List (Node msg))
      -- | NodeNS String String (List (Attribute msg)) (List (Node msg))
    | KeyedNode String (List (Attribute msg)) (List ( String, Node msg ))
    | StyledNode String (List Declaration) (List (Attribute msg)) (List (Node msg))
      -- | StyledNodeNS String String (List Declaration) (List (Attribute msg)) (List (Node msg))
    | StyledKeyedNode String (List Declaration) (List (Attribute msg)) (List ( String, Node msg ))


withStyles : List Statement -> List (Node msg) -> List (V.Node msg)
withStyles statments nodes =
    let
        ( nodes_, styleDict ) =
            List.foldr
                folder
                ( [], Dict.empty )
                nodes
    in
    (G.toStyleElement statments <| toTextNodes styleDict)
        :: nodes_


toHtml : Node msg -> V.Node msg
toHtml node_ =
    case node_ of
        Text str ->
            V.text str

        Node tag attributes children ->
            toStyledNode Nothing tag attributes children

        KeyedNode tag attributes children ->
            toStyledKeyedNode Nothing tag attributes children

        StyledNode tag declarations attributes children ->
            toStyledNode
                (getHashAndString declarations)
                tag
                attributes
                children

        StyledKeyedNode tag declarations attributes children ->
            toStyledKeyedNode
                (getHashAndString declarations)
                tag
                attributes
                children


toStyledNode :
    Maybe ( Int, String )
    -> String
    -> List (Attribute msg)
    -> List (Node msg)
    -> V.Node msg
toStyledNode maybeHashAndString tag attributes children =
    let
        ( dict, newAttributes ) =
            toStyledNodeHelper maybeHashAndString attributes

        ( children_, styleDict ) =
            List.foldr
                folder
                ( [], dict )
                children
    in
    V.node tag newAttributes (addStyleNode styleDict children_)



-- TODO: figure out a helper function make this not just a copy-past of the non-keyed version


toStyledKeyedNode :
    Maybe ( Int, String )
    -> String
    -> List (Attribute msg)
    -> List ( String, Node msg )
    -> V.Node msg
toStyledKeyedNode maybeHashAndString tag attributes children =
    let
        ( dict, newAttributes ) =
            toStyledNodeHelper maybeHashAndString attributes

        ( children_, styleDict ) =
            List.foldr
                folder
                ( [], dict )
                (List.map Tuple.second children)
    in
    V.keyedNode tag
        newAttributes
        (addKeyedStyleNode
            styleDict
            (List.map2
                (\( id, _ ) child -> ( id, child ))
                children
                children_
            )
        )


toStyledNodeHelper :
    Maybe ( Int, String )
    -> List (Attribute msg)
    -> ( Dict Int String, List (Attribute msg) )
toStyledNodeHelper maybeHashAndString attributes =
    case maybeHashAndString of
        Just ( hash, decsStr ) ->
            ( Dict.singleton hash decsStr
            , addClass hash attributes
            )

        Nothing ->
            ( Dict.empty
            , attributes
            )


addStyleNode : Dict Int String -> List (V.Node msg) -> List (V.Node msg)
addStyleNode styleDict nodes =
    let
        textNodes =
            toTextNodes styleDict
    in
    if List.isEmpty textNodes then
        nodes

    else
        V.node "style" [] textNodes :: nodes



-- TODO: don't use an arbitrary string, maybe use a hash


addKeyedStyleNode : Dict Int String -> List ( String, V.Node msg ) -> List ( String, V.Node msg )
addKeyedStyleNode =
    (::) << Tuple.pair "asdfasfasd" << V.node "style" [] << toTextNodes


addClass : Int -> List (Attribute msg) -> List (Attribute msg)
addClass =
    (::) << A.class << (++) "_" << String.fromInt


folder :
    Node msg
    -> ( List (V.Node msg), Dict Int String )
    -> ( List (V.Node msg), Dict Int String )
folder node_ ( children, styleDict ) =
    let
        ( newNode, newStyleDict ) =
            folderHelper styleDict node_
    in
    ( newNode :: children, newStyleDict )


folderHelper :
    Dict Int String
    -> Node msg
    -> ( V.Node msg, Dict Int String )
folderHelper styleDict node_ =
    case node_ of
        Text str ->
            ( V.text str, styleDict )

        Node tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        children
            in
            ( V.node tag attributes children_, newStyleDict )

        -- NodeNS someStr otherStr attributes children ->
        --     V.nodeNS someStr otherStr attributes <| folder (folderHelper seed styleDict) children
        KeyedNode tag attributes children ->
            let
                ( children_, newStyleDict ) =
                    List.foldr
                        folder
                        ( [], styleDict )
                        (List.map Tuple.second children)
            in
            ( V.keyedNode tag
                attributes
                (List.map2
                    (\( id, _ ) child -> ( id, child ))
                    children
                    children_
                )
            , newStyleDict
            )

        StyledNode tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        children
                        styleDict
            in
            ( V.node tag newAttributes children_, newStyleDict )

        -- StyledNodeNS someStr otherStr declarations attributes children ->
        --     let
        --         ( decStr, hash ) =
        --             getHashAndString seed declarations
        --     in
        --     V.nodeNS someStr otherStr attributes <|
        --         folder
        --             (folderHelper hash <|
        --                 Dict.insert hash decStr styleDict
        --             )
        --             children
        StyledKeyedNode tag declarations attributes children ->
            let
                ( newAttributes, ( children_, newStyleDict ) ) =
                    folderHelperHelper
                        (getHashAndString declarations)
                        attributes
                        (List.map Tuple.second children)
                        styleDict
            in
            ( V.keyedNode tag
                attributes
                (List.map2
                    (\( id, _ ) child -> ( id, child ))
                    children
                    children_
                )
            , newStyleDict
            )


folderHelperHelper :
    Maybe ( Int, String )
    -> List (Attribute msg)
    -> List (Node msg)
    -> Dict Int String
    -> ( List (Attribute msg), ( List (V.Node msg), Dict Int String ) )
folderHelperHelper maybeHashAndString attributes nodes styleDict =
    case maybeHashAndString of
        Just ( hash, decsStr ) ->
            ( addClass hash attributes
            , List.foldr folder
                ( [], Dict.insert hash decsStr styleDict )
                nodes
            )

        Nothing ->
            ( attributes
            , List.foldr folder
                ( [], styleDict )
                nodes
            )



-- potentially want to use keyed nodes


toTextNodes : Dict Int String -> List (V.Node msg)
toTextNodes =
    Dict.toList
        >> List.map
            (\( hash, ruleTemplate ) ->
                V.text <|
                    String.replace
                        I.tmpClass
                        ((++) "._" <| String.fromInt hash)
                        ruleTemplate
            )


getHashAndString : List Declaration -> Maybe ( Int, String )
getHashAndString declarations =
    let
        maybeDecStr =
            I.toString declarations
    in
    Maybe.map
        (\decsStr -> ( M.hashString seed decsStr, decsStr ))
        maybeDecStr


seed : Int
seed =
    0


type alias Html msg =
    Node msg


type alias Attribute msg =
    V.Attribute msg


text : String -> Html msg
text =
    Text


node : String -> List (Attribute msg) -> List (Node msg) -> Node msg
node =
    Node


nodeS : String -> List Declaration -> List (Attribute msg) -> List (Node msg) -> Node msg
nodeS =
    StyledNode



--map : (a -> msg) -> Node a -> Node msg


h1 : List (Attribute msg) -> List (Html msg) -> Html msg
h1 =
    Node "h1"


h1S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h1S =
    StyledNode "h1"


h2 : List (Attribute msg) -> List (Html msg) -> Html msg
h2 =
    Node "h2"


h2S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h2S =
    StyledNode "h2"


h3 : List (Attribute msg) -> List (Html msg) -> Html msg
h3 =
    Node "h3"


h3S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h3S =
    StyledNode "h3"


h4 : List (Attribute msg) -> List (Html msg) -> Html msg
h4 =
    Node "h4"


h4S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h4S =
    StyledNode "h4"


h5 : List (Attribute msg) -> List (Html msg) -> Html msg
h5 =
    Node "h5"


h5S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h5S =
    StyledNode "h5"


h6 : List (Attribute msg) -> List (Html msg) -> Html msg
h6 =
    Node "h6"


h6S : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
h6S =
    StyledNode "h6"


div : List (Attribute msg) -> List (Html msg) -> Html msg
div =
    Node "div"


divS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
divS =
    StyledNode "div"


p : List (Attribute msg) -> List (Html msg) -> Html msg
p =
    Node "p"


pS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
pS =
    StyledNode "p"


hr : List (Attribute msg) -> List (Html msg) -> Html msg
hr =
    Node "hr"


hrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
hrS =
    StyledNode "hr"


pre : List (Attribute msg) -> List (Html msg) -> Html msg
pre =
    Node "pre"


preS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
preS =
    StyledNode "pre"


blockquote : List (Attribute msg) -> List (Html msg) -> Html msg
blockquote =
    Node "blockquote"


blockquoteS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
blockquoteS =
    StyledNode "blockquote"


span : List (Attribute msg) -> List (Html msg) -> Html msg
span =
    Node "span"


spanS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
spanS =
    StyledNode "span"


a : List (Attribute msg) -> List (Html msg) -> Html msg
a =
    Node "a"


aS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
aS =
    StyledNode "a"


code : List (Attribute msg) -> List (Html msg) -> Html msg
code =
    Node "code"


codeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
codeS =
    StyledNode "code"


em : List (Attribute msg) -> List (Html msg) -> Html msg
em =
    Node "em"


emS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
emS =
    StyledNode "em"


strong : List (Attribute msg) -> List (Html msg) -> Html msg
strong =
    Node "strong"


strongS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
strongS =
    StyledNode "strong"


i : List (Attribute msg) -> List (Html msg) -> Html msg
i =
    Node "i"


iS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
iS =
    StyledNode "i"


b : List (Attribute msg) -> List (Html msg) -> Html msg
b =
    Node "b"


bS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bS =
    StyledNode "b"


u : List (Attribute msg) -> List (Html msg) -> Html msg
u =
    Node "u"


uS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
uS =
    StyledNode "u"


sub : List (Attribute msg) -> List (Html msg) -> Html msg
sub =
    Node "sub"


subS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
subS =
    StyledNode "sub"


sup : List (Attribute msg) -> List (Html msg) -> Html msg
sup =
    Node "sup"


supS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
supS =
    StyledNode "sup"


br : List (Attribute msg) -> List (Html msg) -> Html msg
br =
    Node "br"


brS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
brS =
    StyledNode "br"


ol : List (Attribute msg) -> List (Html msg) -> Html msg
ol =
    Node "ol"


olS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
olS =
    StyledNode "ol"


ul : List (Attribute msg) -> List (Html msg) -> Html msg
ul =
    Node "ul"


ulS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
ulS =
    StyledNode "ul"


li : List (Attribute msg) -> List (Html msg) -> Html msg
li =
    Node "li"


liS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
liS =
    StyledNode "li"


dl : List (Attribute msg) -> List (Html msg) -> Html msg
dl =
    Node "dl"


dlS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dlS =
    StyledNode "dl"


dt : List (Attribute msg) -> List (Html msg) -> Html msg
dt =
    Node "dt"


dtS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dtS =
    StyledNode "dt"


dd : List (Attribute msg) -> List (Html msg) -> Html msg
dd =
    Node "dd"


ddS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
ddS =
    StyledNode "dd"


img : List (Attribute msg) -> List (Html msg) -> Html msg
img =
    Node "img"


imgS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
imgS =
    StyledNode "img"


iframe : List (Attribute msg) -> List (Html msg) -> Html msg
iframe =
    Node "iframe"


iframeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
iframeS =
    StyledNode "iframe"


canvas : List (Attribute msg) -> List (Html msg) -> Html msg
canvas =
    Node "canvas"


canvasS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
canvasS =
    StyledNode "canvas"


math : List (Attribute msg) -> List (Html msg) -> Html msg
math =
    Node "math"


mathS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
mathS =
    StyledNode "math"


form : List (Attribute msg) -> List (Html msg) -> Html msg
form =
    Node "form"


formS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
formS =
    StyledNode "form"


input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    Node "input"


inputS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
inputS =
    StyledNode "input"


textarea : List (Attribute msg) -> List (Html msg) -> Html msg
textarea =
    Node "textarea"


textareaS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
textareaS =
    StyledNode "textarea"


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    Node "button"


buttonS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
buttonS =
    StyledNode "button"


select : List (Attribute msg) -> List (Html msg) -> Html msg
select =
    Node "select"


selectS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
selectS =
    StyledNode "select"


option : List (Attribute msg) -> List (Html msg) -> Html msg
option =
    Node "option"


optionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
optionS =
    StyledNode "option"


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    Node "section"


sectionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sectionS =
    StyledNode "section"


nav : List (Attribute msg) -> List (Html msg) -> Html msg
nav =
    Node "nav"


navS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
navS =
    StyledNode "nav"


article : List (Attribute msg) -> List (Html msg) -> Html msg
article =
    Node "article"


articleS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
articleS =
    StyledNode "article"


aside : List (Attribute msg) -> List (Html msg) -> Html msg
aside =
    Node "aside"


asideS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
asideS =
    StyledNode "aside"


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    Node "header"


headerS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
headerS =
    StyledNode "header"


footer : List (Attribute msg) -> List (Html msg) -> Html msg
footer =
    Node "footer"


footerS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
footerS =
    StyledNode "footer"


address : List (Attribute msg) -> List (Html msg) -> Html msg
address =
    Node "address"


addressS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
addressS =
    StyledNode "address"


main_ : List (Attribute msg) -> List (Html msg) -> Html msg
main_ =
    Node "main"


mainS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
mainS =
    StyledNode "main"


figure : List (Attribute msg) -> List (Html msg) -> Html msg
figure =
    Node "figure"


figureS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
figureS =
    StyledNode "figure"


figcaption : List (Attribute msg) -> List (Html msg) -> Html msg
figcaption =
    Node "figcaption"


figcaptionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
figcaptionS =
    StyledNode "figcaption"


table : List (Attribute msg) -> List (Html msg) -> Html msg
table =
    Node "table"


tableS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tableS =
    StyledNode "table"


caption : List (Attribute msg) -> List (Html msg) -> Html msg
caption =
    Node "caption"


captionS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
captionS =
    StyledNode "caption"


colgroup : List (Attribute msg) -> List (Html msg) -> Html msg
colgroup =
    Node "colgroup"


colgroupS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
colgroupS =
    StyledNode "colgroup"


col : List (Attribute msg) -> List (Html msg) -> Html msg
col =
    Node "col"


colS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
colS =
    StyledNode "col"


tbody : List (Attribute msg) -> List (Html msg) -> Html msg
tbody =
    Node "tbody"


tbodyS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tbodyS =
    StyledNode "tbody"


thead : List (Attribute msg) -> List (Html msg) -> Html msg
thead =
    Node "thead"


theadS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
theadS =
    StyledNode "thead"


tfoot : List (Attribute msg) -> List (Html msg) -> Html msg
tfoot =
    Node "tfoot"


tfootS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tfootS =
    StyledNode "tfoot"


tr : List (Attribute msg) -> List (Html msg) -> Html msg
tr =
    Node "tr"


trS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
trS =
    StyledNode "tr"


td : List (Attribute msg) -> List (Html msg) -> Html msg
td =
    Node "td"


tdS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
tdS =
    StyledNode "td"


th : List (Attribute msg) -> List (Html msg) -> Html msg
th =
    Node "th"


thS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
thS =
    StyledNode "th"


fieldset : List (Attribute msg) -> List (Html msg) -> Html msg
fieldset =
    Node "fieldset"


fieldsetS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
fieldsetS =
    StyledNode "fieldset"


legend : List (Attribute msg) -> List (Html msg) -> Html msg
legend =
    Node "legend"


legendS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
legendS =
    StyledNode "legend"


label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    Node "label"


labelS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
labelS =
    StyledNode "label"


datalist : List (Attribute msg) -> List (Html msg) -> Html msg
datalist =
    Node "datalist"


datalistS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
datalistS =
    StyledNode "datalist"


optgroup : List (Attribute msg) -> List (Html msg) -> Html msg
optgroup =
    Node "optgroup"


optgroupS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
optgroupS =
    StyledNode "optgroup"


output : List (Attribute msg) -> List (Html msg) -> Html msg
output =
    Node "output"


outputS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
outputS =
    StyledNode "output"


progress : List (Attribute msg) -> List (Html msg) -> Html msg
progress =
    Node "progress"


progressS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
progressS =
    StyledNode "progress"


meter : List (Attribute msg) -> List (Html msg) -> Html msg
meter =
    Node "meter"


meterS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
meterS =
    StyledNode "meter"


audio : List (Attribute msg) -> List (Html msg) -> Html msg
audio =
    Node "audio"


audioS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
audioS =
    StyledNode "audio"


video : List (Attribute msg) -> List (Html msg) -> Html msg
video =
    Node "video"


videoS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
videoS =
    StyledNode "video"


source : List (Attribute msg) -> List (Html msg) -> Html msg
source =
    Node "source"


sourceS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sourceS =
    StyledNode "source"


track : List (Attribute msg) -> List (Html msg) -> Html msg
track =
    Node "track"


trackS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
trackS =
    StyledNode "track"


embed : List (Attribute msg) -> List (Html msg) -> Html msg
embed =
    Node "embed"


embedS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
embedS =
    StyledNode "embed"


object : List (Attribute msg) -> List (Html msg) -> Html msg
object =
    Node "object"


objectS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
objectS =
    StyledNode "object"


param : List (Attribute msg) -> List (Html msg) -> Html msg
param =
    Node "param"


paramS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
paramS =
    StyledNode "param"


ins : List (Attribute msg) -> List (Html msg) -> Html msg
ins =
    Node "ins"


insS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
insS =
    StyledNode "ins"


del : List (Attribute msg) -> List (Html msg) -> Html msg
del =
    Node "del"


delS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
delS =
    StyledNode "del"


small : List (Attribute msg) -> List (Html msg) -> Html msg
small =
    Node "small"


smallS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
smallS =
    StyledNode "small"


cite : List (Attribute msg) -> List (Html msg) -> Html msg
cite =
    Node "cite"


citeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
citeS =
    StyledNode "cite"


dfn : List (Attribute msg) -> List (Html msg) -> Html msg
dfn =
    Node "dfn"


dfnS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
dfnS =
    StyledNode "dfn"


abbr : List (Attribute msg) -> List (Html msg) -> Html msg
abbr =
    Node "abbr"


abbrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
abbrS =
    StyledNode "abbr"


time : List (Attribute msg) -> List (Html msg) -> Html msg
time =
    Node "time"


timeS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
timeS =
    StyledNode "time"


var : List (Attribute msg) -> List (Html msg) -> Html msg
var =
    Node "var"


varS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
varS =
    StyledNode "var"


samp : List (Attribute msg) -> List (Html msg) -> Html msg
samp =
    Node "samp"


sampS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sampS =
    StyledNode "samp"


kbd : List (Attribute msg) -> List (Html msg) -> Html msg
kbd =
    Node "kbd"


kbdS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
kbdS =
    StyledNode "kbd"


s : List (Attribute msg) -> List (Html msg) -> Html msg
s =
    Node "s"


sS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
sS =
    StyledNode "s"


q : List (Attribute msg) -> List (Html msg) -> Html msg
q =
    Node "q"


qS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
qS =
    StyledNode "q"


mark : List (Attribute msg) -> List (Html msg) -> Html msg
mark =
    Node "mark"


markS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
markS =
    StyledNode "mark"


ruby : List (Attribute msg) -> List (Html msg) -> Html msg
ruby =
    Node "ruby"


rubyS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rubyS =
    StyledNode "ruby"


rt : List (Attribute msg) -> List (Html msg) -> Html msg
rt =
    Node "rt"


rtS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rtS =
    StyledNode "rt"


rp : List (Attribute msg) -> List (Html msg) -> Html msg
rp =
    Node "rp"


rpS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
rpS =
    StyledNode "rp"


bdi : List (Attribute msg) -> List (Html msg) -> Html msg
bdi =
    Node "bdi"


bdiS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bdiS =
    StyledNode "bdi"


bdo : List (Attribute msg) -> List (Html msg) -> Html msg
bdo =
    Node "bdo"


bdoS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
bdoS =
    StyledNode "bdo"


wbr : List (Attribute msg) -> List (Html msg) -> Html msg
wbr =
    Node "wbr"


wbrS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
wbrS =
    StyledNode "wbr"


details : List (Attribute msg) -> List (Html msg) -> Html msg
details =
    Node "details"


detailsS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
detailsS =
    StyledNode "details"


summary : List (Attribute msg) -> List (Html msg) -> Html msg
summary =
    Node "summary"


summaryS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
summaryS =
    StyledNode "summary"


menuitem : List (Attribute msg) -> List (Html msg) -> Html msg
menuitem =
    Node "menuitem"


menuitemS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
menuitemS =
    StyledNode "menuitem"


menu : List (Attribute msg) -> List (Html msg) -> Html msg
menu =
    Node "menu"


menuS : List Declaration -> List (Attribute msg) -> List (Html msg) -> Html msg
menuS =
    StyledNode "menu"
