module Main exposing (..)

import Html exposing (..)
import Random
import Html.Events exposing (..)
import List
import Html.Attributes exposing (class, target, href, property, defaultValue)
import Json.Decode exposing (..)
import Keywords exposing (list)
import String exposing (length, repeat, left, concat)
import Regex exposing (split)
import Strokes exposing (json)


--TODO: Import Dependencies
--TODO: Make function which takes list of Html Msgs, and calls List.map with text node


iter : Int -> List Int
iter count =
    List.repeat count (0)


tospan : String -> Html msg
tospan str =
    span [] [ text str ]


mapstyles : List -> String -> Html msg



-- TODO: Decode json
-- TODO: Map and Return HTML


preplength : Int -> String -> String
preplength goal str =
    let
        strlength =
            length str
    in
        if (strlength < goal) then
            let
                new =
                    repeat ((goal // strlength) + 1) str
            in
                left goal new
        else
            left goal str


sew : Int -> String -> String -> List String -> Html msg
sew num rows j words =
    let
        str =
            preplength num (String.concat words)
    in
        mapstyles (split rows str) j


main : Html msg
main =
    sew 5244 ".{1,114}" json Keywords.list
