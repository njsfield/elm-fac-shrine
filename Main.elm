module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, target, href, property, defaultValue)
import String exposing (length, repeat, left, dropLeft, concat, toInt)
import List exposing (repeat, map, length, take, drop)
import Result
import Maybe exposing (..)
import Tuple exposing (first, second)
import Debug exposing (log)
import Regex exposing (split, regex, find)
import Asciimap exposing (asciimap)


iter : Int -> List Int
iter count =
    List.repeat count (0)


tospan : String -> String -> Html msg
tospan colour words =
    span [ class colour ] [ text words ]


components : String -> List (List String)
components string =
    string
        |> split Regex.All (regex ", ")
        |> List.map (\rule -> split Regex.All (regex " ") rule)


elongate : Int -> String -> String
elongate goal str =
    if ((String.length str) < goal) then
        let
            new =
                str
                    |> String.repeat ((goal // (String.length str)) + 1)
        in
            left goal new
    else
        left goal str


areaify : Int -> Int -> Int -> Int
areaify x y p =
    x * (y + (2 * p))


dividestring : Int -> String -> List String
dividestring chars string =
    let
        reg =
            ".{0," ++ (toString chars) ++ "}"
    in
        List.map .match (Regex.find Regex.All (Regex.regex reg) string)


findfirst : String -> String -> String
findfirst str reg =
    let
        res =
            List.map .match (Regex.find (Regex.AtMost 1) (Regex.regex reg) str)
    in
        String.concat res


reduceby : Int -> List String -> List String
reduceby num list =
    let
        length =
            List.length list
    in
        list
            |> List.take (length - num)
            |> List.drop num


toIntOr : String -> Int -> Int
toIntOr attempt default =
    case toInt attempt of
        Err _ ->
            default

        Ok good ->
            good


asciirow : ( String, String ) -> List (Html msg)
asciirow mixed =
    let
        ( wordstr, rulestr ) =
            mixed

        dtotal =
            String.length wordstr

        amount =
            toIntOr (findfirst rulestr "\\d*") dtotal

        colour =
            findfirst rulestr "[a-z]+"

        ( targ, rest ) =
            ( (left amount wordstr), (dropLeft amount wordstr) )

        otherrules =
            dropLeft
                ((String.length (toString amount)) + (String.length colour) + 3)
                rulestr
    in
        if dtotal == 0 then
            []
        else
            let
                stroke =
                    span [ class colour ] [ text targ ]
            in
                stroke :: asciirow ( rest, otherrules )


main : Html msg
main =
    let
        { xlength, ylength, padlength, padcolour, strokes, keywords } =
            asciimap

        wordrows =
            concat keywords
                |> elongate (areaify xlength ylength padlength)
                |> dividestring xlength

        padstrokes =
            iter padlength
                |> List.map (\_ -> ((toString xlength) ++ ", " ++ padcolour))

        mainart =
            List.map2 (,) (reduceby padlength wordrows) strokes
                |> List.map (\x -> p [] (asciirow x))

        paddingart =
            List.map2 (,) (List.take padlength wordrows) padstrokes
                |> List.map (\x -> p [] (asciirow x))

        spans =
            paddingart ++ mainart ++ paddingart
    in
        span [] spans
