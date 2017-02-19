module Main exposing (..)

import Html exposing (..)
import Random exposing (generate, int)


-- Custom Imports

import Asciimap exposing (asciimap)
import GenerateAscii exposing (generateascii)
import ListShuffler exposing (listshuffler)
import Model exposing (Model)


-- Main


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Init


init : ( Model, Cmd Msg )
init =
    ( asciimap, generate Newseed (int 200 400) )



-- UPDATE


type Msg
    = Newseed Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Newseed num ->
            ( { model | keywords = listshuffler num model.keywords }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    generateascii model
