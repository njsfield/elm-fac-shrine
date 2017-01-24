module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, target, href, property, defaultValue)
import String exposing (length, repeat, left, concat, toInt)
import List
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
    if ((length str) < goal) then
        let
            new =
                str
                    |> repeat ((goal // (length str)) + 1)
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
    case toString attempt of
        Err _ ->
            default

        Ok good ->
            good


asciirow : ( String, List (List String) ) -> List (Html msg)
asciirow mixed =
    let
        ( words, rules ) =
            mixed

        dtotal =
            length words

        -- dtotalstr =
        --     toString dtotal
        --
        -- dcolour =
        --     "grey"
        -- rule =
        --     Maybe.withDefault [ dtotalstr, dcolour ] (List.head rules)
        --
        -- amountstr =
        --     Maybe.withDefault dtotalstr (List.head rule)
        amount =
            toIntOr () dtotal

        colour =
            Maybe.withDefault dcolour (List.head (List.reverse rule))

        thisstring =
            String.slice 0 amount words

        otherstring =
            String.slice amount dtotal words

        otherrules =
            Maybe.withDefault [] (List.tail (second mixed))
    in
        if dtotal == 0 then
            []
        else
            let
                stroke =
                    span [ class colour ] [ text thisstring ]
            in
                stroke :: asciirow ( otherstring, otherrules )


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
            (toString xlength) ++ ", " ++ padcolour

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
