module ListShuffler exposing (listshuffler)

import List exposing (sortBy, unzip, length, map2)
import Tuple exposing (first, second)
import Random exposing (list, int, initialSeed, step)


listshuffler : Int -> List a -> List a
listshuffler num olist =
    let
        olength =
            length olist

        rnums =
            step (list olength (int 1 olength)) (initialSeed num)
                |> first
    in
        map2 (,) rnums olist
            |> sortBy first
            |> unzip
            |> second
