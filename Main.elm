module Main exposing (..)

import Html exposing (..)
import Random
import Html.Events exposing (..)
import List
import Html.Attributes exposing (class, target, href, property, defaultValue)
import Json.Decode exposing (..)
import Keywords
import Strokes


--TODO: Import Dependencies
--TODO: Make function which takes list of Html Msgs, and calls List.map with text node


spans : List (Html msg)
spans =
    [ span [] [ text "hello" ], text "\n", span [] [ text "world" ], text "\n" ]



-- addnewline : Html msg -> Html msg
-- addnewline elt =
--     (elt [ text "\n" ])


iterator : List Int
iterator =
    List.repeat 8 (0)


makewordjumble : List Int -> List String -> String
makewordjumble counter words =
    String.concat (List.map counter)


main : Html msg
main =
    span [] spans
