module Fuzzers exposing (datetime, datetimeAndString)

import Date exposing (Date)
import Fuzz exposing (Fuzzer, int, list, string)


toFixed : Int -> String
toFixed num =
    if num < 10 then
        "0" ++ (toString num)
    else
        toString num


yearFuzzer : Fuzzer Int
yearFuzzer =
    Fuzz.intRange 1970 2029


monthFuzzer : Fuzzer Int
monthFuzzer =
    Fuzz.intRange 1 12


dayFuzzer : Fuzzer Int
dayFuzzer =
    Fuzz.intRange 1 28


hourFuzzer : Fuzzer Int
hourFuzzer =
    Fuzz.intRange 0 23


minuteFuzzer : Fuzzer Int
minuteFuzzer =
    Fuzz.intRange 0 59


secondFuzzer : Fuzzer Int
secondFuzzer =
    Fuzz.intRange 0 59


dateStringFuzzer : Fuzzer String
dateStringFuzzer =
    Fuzz.map3 buildDateString yearFuzzer monthFuzzer dayFuzzer


timeStringFuzzer : Fuzzer String
timeStringFuzzer =
    Fuzz.map3 buildTimeString hourFuzzer minuteFuzzer secondFuzzer


datetimeStringFuzzer : Fuzzer String
datetimeStringFuzzer =
    Fuzz.map2 buildDatetimeString dateStringFuzzer timeStringFuzzer


buildDateString : Int -> Int -> Int -> String
buildDateString year month day =
    (toFixed year) ++ "-" ++ (toFixed month) ++ "-" ++ (toFixed day)


buildTimeString : Int -> Int -> Int -> String
buildTimeString hour minute second =
    (toFixed hour) ++ ":" ++ (toFixed minute) ++ ":" ++ (toFixed second)


buildDatetimeString : String -> String -> String
buildDatetimeString date time =
    date ++ "T" ++ time ++ ".000"


datetime : Fuzzer Date
datetime =
    Fuzz.map parseDate datetimeStringFuzzer


datetimeAndString : Fuzzer ( Date, String )
datetimeAndString =
    Fuzz.map2 buildDatetimeAndString datetime (Fuzz.string)


buildDatetimeAndString : Date -> String -> ( Date, String )
buildDatetimeAndString date someString =
    ( date, someString )


parseDate : String -> Date
parseDate dateString =
    case Date.fromString dateString of
        Ok date ->
            date

        Err _ ->
            Debug.crash "Fuzzers don't work, man!"
