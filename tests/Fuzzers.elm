module Fuzzers exposing (datetime, datetimeAndString)

import Fuzz exposing (Fuzzer, int, list, string)
import Time exposing (Posix)


datetime : Fuzzer Posix
datetime =
    Fuzz.map Time.millisToPosix
        (Fuzz.intRange
            1529000000
            1530000000
        )


datetimeAndString : Fuzzer ( Posix, String )
datetimeAndString =
    Fuzz.map2 Tuple.pair datetime Fuzz.string
