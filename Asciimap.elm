module Asciimap exposing (asciimap)


type alias Asciimap =
    { xlength : Int
    , ylength : Int
    , padlength : Int
    , padcolour : String
    , strokes : List String
    , keywords : List String
    }


asciimap : Asciimap
asciimap =
    { xlength = 115
    , ylength = 26
    , padlength = 10
    , padcolour = "grey"
    , strokes =
        [ "56 grey, 3 white, 56 grey"
        , "51 grey, 13 white, 51 grey"
        , "48 grey, 19 white, 48 grey"
        , "46 grey, 23 white, 46 grey"
        , "45 grey, 25 white, 45 grey"
        , "44 grey, 17 white, 1 leafgreen, 9 white, 44 grey"
        , "43 grey, 17 white, 3 leafgreen, 9 white, 43 grey"
        , "43 grey, 15 white, 5 leafgreen, 9 white, 43 grey"
        , "43 grey, 14 white, 6 leafgreen, 9 white, 43 grey"
        , "43 grey, 7 white, 1 leafgreen, 7 white, 3 leafgreen, 11 white, 43 grey"
        , "43 grey, 4 white, 8 leafgreen, 3 white, 2 leafgreen, 12 white, 43 grey"
        , "44 grey, 6 white, 5 leafgreen, 3 white, 1 midgreen, 12 white, 44 grey"
        , "45 grey, 8 white, 3 leafgreen, 2 white, 1 midgreen, 2 white, 1 midgreen, 8 white, 45 grey"
        , "46 grey, 8 white, 2 midgreen, 2 white, 2 midgreen, 9 white, 46 grey"
        , "47 grey, 9 white, 1 midgreen, 1 white, 1 midgreen, 9 white, 47 grey"
        , "48 grey, 9 white, 2 midgreen, 8 white, 48 grey"
        , "49 grey, 9 white, 1 midgreen, 7 white, 49 grey"
        , "50 grey, 8 white, 1 darkgreen, 6 white, 50 grey"
        , "50 grey, 8 white, 1 darkgreen, 6 white, 50 grey"
        , "50 grey, 3 white, 10 black, 2 white, 50 grey"
        , "51 grey, 13 white, 51 grey"
        , "52 grey, 6 black, 4 grey 1 black, 52 grey"
        , "52 grey, 1 lightgrey, 6 black, 1 grey, 3 lightgrey, 52 grey"
        , "52 grey, 8 black, 4 grey, 1 black, 50 grey"
        , "52 grey, 1 lightgrey, 6 black, 1 grey, 3 lightgrey, 52 grey"
        , "53 grey, 6 black, 56 grey"
        , "55 grey, 5 black, 55 grey"
        ]
    , keywords =
        [ "founders"
        , "coders"
        , "opensource"
        , "community"
        , "team"
        , "cohort"
        , "coding"
        , "javascript"
        , "css"
        , "databases"
        , "cirriculum"
        , "ux"
        , "nonprofit"
        , "ethos"
        , "dwyl"
        , "project"
        , "democracy"
        , "pairprogramming"
        , "ethos"
        , "gitbook"
        , "github"
        , "functionalprogramming"
        , "bootcamp"
        , "learning"
        , "dan"
        , "hapi"
        , "authentication"
        , "postgres"
        , "node"
        , "elm"
        , "react"
        , "redux"
        , "testing"
        , "freelancing"
        , "networking"
        , "html"
        , "london"
        , "nazareth"
        , "design"
        , "userstories"
        , "online"
        , "meetups"
        , "hackathons"
        , "resources"
        , "love"
        , "compassion"
        , "practice"
        , "vanilla"
        , "accessibility"
        , "atom"
        , "postgres"
        , "alumni"
        , "codingforeveryone"
        , "structure"
        , "readme"
        , "research"
        , "tdd"
        , "tdd"
        , "values"
        , "techforgood"
        ]
    }
