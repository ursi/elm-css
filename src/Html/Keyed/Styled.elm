module Html.Keyed.Styled exposing
    ( node, nodeS
    , ol, olS, ul, ulS
    )

{-| A keyed node helps optimize cases where children are getting added, moved,
removed, etc. Common examples include:

  - The user can delete items from a list.
  - The user can create new items in a list.
  - You can sort a list based on name or date or whatever.
    When you use a keyed node, every child is paired with a string identifier. This
    makes it possible for the underlying diffing algorithm to reuse nodes more
    efficiently.


# Keyed Nodes

@docs node, nodeS


# Commonly Keyed Nodes

@docs ol, olS, ul, ulS

-}

import Css.Internal exposing (Declaration)
import VirtualDom.Styled exposing (Attribute, Node(..))


{-| -}
node : String -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
node =
    KeyedNode


{-| -}
nodeS :
    String
    -> List Declaration
    -> List (Attribute msg)
    -> List ( String, Node msg )
    -> Node msg
nodeS =
    StyledKeyedNode


{-| -}
ol : List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ol =
    node "ol"


{-| -}
olS : List Declaration -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
olS =
    nodeS "ol"


{-| -}
ul : List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ul =
    node "ul"


{-| -}
ulS : List Declaration -> List (Attribute msg) -> List ( String, Node msg ) -> Node msg
ulS =
    nodeS "ul"
