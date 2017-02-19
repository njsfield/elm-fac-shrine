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
import Task exposing (..)
import Random exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { xlength : Int
    , ylength : Int
    , padlength : Int
    , padcolour : String
    , strokes : List String
    , keywords : List String
    }



-- Init


init : ( Model, Cmd Msg )
init =
    ( asciimap, Random.generate Paint (Random.int 100 200) )


keywordshuffler : Int -> Model -> Model
keywordshuffler key model =
    let
        { keywords } =
            model

        klength =
            List.length keywords

        rnums =
            Random.step (Random.list klength (Random.int 1 klength)) (Random.initialSeed key)
                |> Tuple.first

        newlist =
            List.map2 (,) rnums keywords
                |> List.sortBy Tuple.first
                |> List.unzip
                |> Tuple.second
    in
        { model | keywords = newlist }


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
            [ text "\n" ]
        else
            let
                stroke =
                    span [ class colour ] [ text targ ]
            in
                stroke :: asciirow ( rest, otherrules )



-- UPDATE


type Msg
    = Paint Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Paint num ->
            ( keywordshuffler num model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        { xlength, ylength, padlength, padcolour, strokes, keywords } =
            model

        wordrows =
            concat keywords
                |> elongate (areaify xlength ylength padlength)
                |> dividestring xlength

        padstrokes =
            iter padlength
                |> List.map (\_ -> ((toString xlength) ++ ", " ++ padcolour))

        mainart =
            List.map2 (,) (reduceby padlength wordrows) strokes
                |> List.map asciirow
                |> List.concat

        paddingart =
            List.map2 (,) (List.take padlength wordrows) padstrokes
                |> List.map asciirow
                |> List.concat
    in
        span [] (List.concat [ paddingart, mainart, paddingart ])
