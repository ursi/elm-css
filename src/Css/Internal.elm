module Css.Internal exposing
    ( Declaration(..)
    , joinMap
    , seed
    , tmpClass
    , toPairsDict
    , toString
    )

import Dict exposing (Dict)


type Declaration
    = Single (String -> String) String String
    | Batch (List Declaration)


joinMap : (a -> String) -> String -> List a -> String
joinMap f sep list =
    case list of
        [ only ] ->
            f only

        first :: rest ->
            f first ++ sep ++ joinMap f sep rest

        [] ->
            ""


seed : Int
seed =
    0


toString : List Declaration -> Maybe String
toString declarations =
    if List.isEmpty declarations then
        Nothing

    else
        declarations
            |> toPairsDict
            |> Dict.toList
            |> joinMap
                (\( selector, pairs ) ->
                    selector
                        ++ " {\n"
                        ++ (pairs
                                |> joinMap
                                    (\( property, value ) ->
                                        "\t" ++ property ++ ": " ++ value ++ ";"
                                    )
                                    "\n"
                           )
                        ++ "\n}"
                )
                "\n"
            |> Just


tmpClass : String
tmpClass =
    "!@#$%^&*()"


toPairsDict : List Declaration -> Dict String (List ( String, String ))
toPairsDict =
    toPairsDictFrom Dict.empty


toPairsDictFrom : Dict String (List ( String, String )) -> List Declaration -> Dict String (List ( String, String ))
toPairsDictFrom pairsDict declarations =
    case declarations of
        first :: rest ->
            case first of
                Single classToSelector property value ->
                    let
                        selector =
                            classToSelector tmpClass
                    in
                    toPairsDictFrom
                        (Dict.insert selector
                            (case Dict.get selector pairsDict of
                                Just pairs ->
                                    ( property, value ) :: pairs

                                Nothing ->
                                    [ ( property, value ) ]
                            )
                            pairsDict
                        )
                        rest

                Batch declarations_ ->
                    toPairsDictFrom pairsDict <| declarations_ ++ rest

        [] ->
            pairsDict
