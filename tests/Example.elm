module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Date exposing (Date)
import DateFormat


-- Fuzzers for generating random dates


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


datetimeFuzzer : Fuzzer Date
datetimeFuzzer =
    Fuzz.map parseDate datetimeStringFuzzer


parseDate : String -> Date
parseDate dateString =
    case Date.fromString dateString of
        Ok date ->
            date

        Err _ ->
            Debug.crash "Fuzzers don't work, man!"


toFixed : Int -> String
toFixed num =
    if num < 10 then
        "0" ++ (toString num)
    else
        toString num


withinRange : Int -> Int -> DateFormat.Token -> Date -> Expectation
withinRange min max token someDate =
    let
        formattedDate =
            DateFormat.format [ token ] someDate
    in
        stringWithinRange min max formattedDate


fixedWithinRange : Int -> Int -> Int -> DateFormat.Token -> Date -> Expectation
fixedWithinRange len min max token someDate =
    let
        formattedDate =
            DateFormat.format [ token ] someDate
    in
        Expect.all
            [ stringWithinRange min max
            , isLength len
            ]
            formattedDate


formatsWithLength : Int -> DateFormat.Token -> Date -> Expectation
formatsWithLength len token someDate =
    DateFormat.format [ token ] someDate
        |> isLength len


isLength : Int -> String -> Expectation
isLength len str =
    Expect.equal len (String.length str)


stringWithinRange : Int -> Int -> String -> Expectation
stringWithinRange min max string =
    case String.toInt string of
        Ok int ->
            int
                |> Expect.all
                    [ Expect.atLeast min
                    , Expect.atMost max
                    ]

        Err _ ->
            Expect.fail "Doesn't return a number"


suffixWithinRange : Int -> Int -> DateFormat.Token -> Date -> Expectation
suffixWithinRange min max token someDate =
    let
        result =
            DateFormat.format [ token ] someDate
    in
        if endsInSuffix result then
            stringWithinRange min max (String.dropRight 2 result)
        else
            Expect.fail "Doesn't end in a suffix."


endsInSuffix : String -> Bool
endsInSuffix string =
    let
        lastTwoLetters =
            String.right 2 string
    in
        List.member lastTwoLetters [ "st", "nd", "rd", "th" ]


suite : Test
suite =
    describe "The DateFormat Module"
        [ describe "monthNumber"
            [ fuzz datetimeFuzzer "Is between 1 and 12" <|
                withinRange 1 12 DateFormat.monthNumber
            ]
        , describe "monthSuffix"
            [ fuzz datetimeFuzzer "Is between 1 and 12" <|
                suffixWithinRange 1 12 DateFormat.monthSuffix
            ]
        , describe "monthFixed"
            [ fuzz datetimeFuzzer "Is between 1 and 12" <|
                fixedWithinRange 2 1 12 DateFormat.monthFixed
            ]
        , describe "monthNameFirstThree"
            [ fuzz datetimeFuzzer "Is always three characters long" <|
                formatsWithLength 3 DateFormat.monthNameFirstThree
            ]
        ]
