module Model exposing (Model)

-- Model


type alias Model =
    { xlength : Int
    , ylength : Int
    , padlength : Int
    , padcolour : String
    , strokes : List String
    , keywords : List String
    }
