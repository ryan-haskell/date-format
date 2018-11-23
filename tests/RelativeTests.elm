module RelativeTests exposing (suite)

import DateFormat.Relative exposing (relativeTime)
import Expect exposing (Expectation)
import Fuzz
import Test exposing (..)
import Time exposing (Posix, utc)


time =
    Time.millisToPosix 1537190428785


applyDiff diff =
    Time.millisToPosix <| Time.posixToMillis time + diff


addSeconds secs =
    applyDiff (secs * 1000)


addMins mins =
    addSeconds (mins * 60)


addHours hours =
    addMins (hours * 60)


addDays days =
    addHours (days * 24)


addMonths months =
    addDays (months * 30)


suite : Test
suite =
    describe "The DateFormat.Relative module"
        [ test "right now" <|
            \_ -> relativeTime time time |> Expect.equal "right now"
        , fuzz (Fuzz.intRange -29 -1) "last 30s" <|
            \secs ->
                relativeTime time (addSeconds secs)
                    |> Expect.equal "just now"
        , fuzz (Fuzz.intRange -59 -30) "30-59s ago" <|
            \secs ->
                relativeTime time (addSeconds secs)
                    |> Expect.equal (String.fromInt (abs secs) ++ " seconds ago")
        , test "1 min" <|
            \_ ->
                relativeTime time (addMins -1)
                    |> Expect.equal "a minute ago"
        , fuzz (Fuzz.intRange -59 -2) "2-59 mins ago" <|
            \mins ->
                relativeTime time (addMins mins)
                    |> Expect.equal (String.fromInt (abs mins) ++ " minutes ago")
        , test "1 hour" <|
            \_ ->
                relativeTime time (addHours -1)
                    |> Expect.equal "an hour ago"
        , fuzz (Fuzz.intRange -23 -2) "2-23 hours ago" <|
            \hours ->
                relativeTime time (addHours hours)
                    |> Expect.equal (String.fromInt (abs hours) ++ " hours ago")
        , test "yesterday" <|
            \_ ->
                relativeTime time (addDays -1)
                    |> Expect.equal "yesterday"
        , fuzz (Fuzz.intRange -27 -2) "2-27 days ago" <|
            \days ->
                relativeTime time (addDays days)
                    |> Expect.equal (String.fromInt (abs days) ++ " days ago")
        , fuzz (Fuzz.intRange -11 -2) "2-11 months ago" <|
            \days ->
                relativeTime time (addMonths days)
                    |> Expect.equal (String.fromInt (abs days) ++ " months ago")
        , test "12 months ago" <|
            \_ ->
                relativeTime time (addMonths -12)
                    |> Expect.equal "12 months ago"
        , test "last year" <|
            \_ ->
                relativeTime time (addMonths -13)
                    |> Expect.equal "last year"
        , test "last year 2" <|
            \_ ->
                relativeTime time (addMonths -23)
                    |> Expect.equal "last year"
        , test "2 years ago" <|
            \_ ->
                relativeTime time (addMonths -25)
                    |> Expect.equal "2 years ago"
        , fuzz (Fuzz.intRange 1 29) "next 29s" <|
            \secs ->
                relativeTime time (addSeconds secs)
                    |> Expect.equal "in a few seconds"
        , fuzz (Fuzz.intRange 31 59) "31-59s from now" <|
            \secs ->
                relativeTime time (addSeconds secs)
                    |> Expect.equal ("in " ++ String.fromInt (abs secs) ++ " seconds")
        , test "1 min future" <|
            \_ ->
                relativeTime time (addMins 1)
                    |> Expect.equal "in a minute"
        , fuzz (Fuzz.intRange 2 59) "2-59 mins from now" <|
            \mins ->
                relativeTime time (addMins mins)
                    |> Expect.equal ("in " ++ String.fromInt (abs mins) ++ " minutes")
        , test "in 1 hour" <|
            \_ ->
                relativeTime time (addHours 1)
                    |> Expect.equal "in an hour"
        , fuzz (Fuzz.intRange 2 23) "2-23 hours from now" <|
            \hours ->
                relativeTime time (addHours hours)
                    |> Expect.equal ("in " ++ String.fromInt (abs hours) ++ " hours")
        , test "tomorrow" <|
            \_ ->
                relativeTime time (addDays 1)
                    |> Expect.equal "tomorrow"
        , fuzz (Fuzz.intRange 2 27) "2-27 days from now" <|
            \days ->
                relativeTime time (addDays days)
                    |> Expect.equal ("in " ++ String.fromInt (abs days) ++ " days")
        , fuzz (Fuzz.intRange 2 11) "in 2-11 months" <|
            \days ->
                relativeTime time (addMonths days)
                    |> Expect.equal ("in " ++ String.fromInt (abs days) ++ " months")
        , test "in 12 months" <|
            \_ ->
                relativeTime time (addMonths 12)
                    |> Expect.equal "in 12 months"
        , test "in a year" <|
            \_ ->
                relativeTime time (addMonths 13)
                    |> Expect.equal "in a year"
        , test "in a year 2" <|
            \_ ->
                relativeTime time (addMonths 23)
                    |> Expect.equal "in a year"
        , test "in 2 years" <|
            \_ ->
                relativeTime time (addMonths 25)
                    |> Expect.equal "in 2 years"
        ]
