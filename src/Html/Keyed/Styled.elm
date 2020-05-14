module Html.Keyed.Styled exposing (..)

import Css.Internal exposing (Declaration)
import VirtualDom.Styled exposing (Attribute, Node(..))


node : String -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
node =
    KeyedNode


nodeS :
    String
    -> List Declaration
    -> List (Attribute msg)
    -> List ( String, Node msg )
    -> Node msg
nodeS =
    StyledKeyedNode


ol : List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ol =
    node "ol"


olS : List Declaration -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
olS =
    nodeS "ol"


ul : List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ul =
    node "ul"


ulS : List Declaration -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ulS =
    nodeS "ul"
