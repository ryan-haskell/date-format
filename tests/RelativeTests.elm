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
        ]
