module DateFormat.Relative
    exposing
        ( RelativeTimeOptions
        , relativeTime
        , relativeTimeWithOptions
        )

{-| A reliable way to get a pretty message for the relative time difference between two dates.


# Getting relative time for two dates

@docs relativeTime, relativeTimeWithOptions, RelativeTimeOptions

-}

import Date exposing (Date)
import Time exposing (Time)


{-| This function takes in two dates and returns the relative difference!

The date inputs are in **chronological order**, to make it easy to remember.

With `relativeTime`, we see a date with both past _and_ future dates!

Here are a few examples to help:

    relativeTime tenSecondsAgo now ==  "just now"
    relativeTime now tenSecondsInTheFuture ==  "in a few seconds"

    relativeTime fortyThreeMinutesAgo now == "43 minutes ago"

    relativeTime oneHundredDaysAgo now == "100 days ago"
    relativeTime now oneHundredDaysFromNow == "in 100 days"

    -- Order matters!
    relativeTime tenSecondsAgo now ==  "just now"
    relativeTime now tenSecondsAgo ==  "in a few seconds"

-}
relativeTime : Date -> Date -> String
relativeTime =
    relativeTimeWithOptions defaultRelativeOptions


{-| Maybe `relativeTime` is too lame. (Or maybe you speak a different language)

With `relativeTimeWithOptions`, you can provide your own custom messages for each time range.

(That's what `relativeTime` uses under the hood!)

You can provide a set of your own custom options, and use `relativeTimeWithOptions` instead.

-}
relativeTimeWithOptions : RelativeTimeOptions -> Date -> Date -> String
relativeTimeWithOptions options start end =
    let
        differenceInSeconds : Float
        differenceInSeconds =
            toSeconds end - toSeconds start

        time : Time
        time =
            Time.second * abs differenceInSeconds
    in
    relativeTimeWithFunctions time <|
        if differenceInSeconds < 0 then
            RelativeTimeFunctions
                options.someSecondsAgo
                options.someMinutesAgo
                options.someHoursAgo
                options.someDaysAgo
                options.someMonthsAgo
                options.someYearsAgo
        else
            RelativeTimeFunctions
                options.inSomeSeconds
                options.inSomeMinutes
                options.inSomeHours
                options.inSomeDays
                options.inSomeMonths
                options.inSomeYears


{-| Options for configuring your own relative message formats!

For example, here is how `someSecondsAgo` is implemented by default:

    defaultSomeSecondsAgo : Int -> String
    defaultSomeSecondsAgo seconds =
        if seconds < 30 then
            "just now"
        else
            toString seconds ++ " seconds ago"

And here is how `inSomeHours` might look:

    defaultInSomeHours : Int -> String
    defaultInSomeHours hours =
        if hours < 2 then
            "in an hour"
        else
            "in " ++ toString hours ++ " hours"

-}
type alias RelativeTimeOptions =
    { someSecondsAgo : Int -> String
    , someMinutesAgo : Int -> String
    , someHoursAgo : Int -> String
    , someDaysAgo : Int -> String
    , someMonthsAgo : Int -> String
    , someYearsAgo : Int -> String
    , inSomeSeconds : Int -> String
    , inSomeMinutes : Int -> String
    , inSomeHours : Int -> String
    , inSomeDays : Int -> String
    , inSomeMonths : Int -> String
    , inSomeYears : Int -> String
    }


defaultRelativeOptions : RelativeTimeOptions
defaultRelativeOptions =
    { someSecondsAgo = defaultSomeSecondsAgo
    , someMinutesAgo = defaultSomeMinutesAgo
    , someHoursAgo = defaultSomeHoursAgo
    , someDaysAgo = defaultSomeDaysAgo
    , someMonthsAgo = defaultSomeMonthsAgo
    , someYearsAgo = defaultSomeYearsAgo
    , inSomeSeconds = defaultInSomeSeconds
    , inSomeMinutes = defaultInSomeMinutes
    , inSomeHours = defaultInSomeHours
    , inSomeDays = defaultInSomeDays
    , inSomeMonths = defaultInSomeMonths
    , inSomeYears = defaultInSomeYears
    }


toSeconds : Date -> Float
toSeconds date =
    date
        |> Date.toTime
        |> Time.inSeconds


type alias RelativeTimeFunctions =
    { seconds : Int -> String
    , minutes : Int -> String
    , hours : Int -> String
    , days : Int -> String
    , months : Int -> String
    , years : Int -> String
    }


relativeTimeWithFunctions : Time -> RelativeTimeFunctions -> String
relativeTimeWithFunctions time functions =
    if Time.inMinutes time < 1 then
        functions.seconds <| floor (Time.inSeconds time)
    else if Time.inHours time < 1 then
        functions.minutes <| floor (Time.inMinutes time)
    else if Time.inHours time < 24 then
        functions.hours <| floor (Time.inHours time / 1)
    else if Time.inHours time < 24 * 30 then
        functions.days <| floor (Time.inHours time / 24)
    else if Time.inHours time < 24 * 365 then
        functions.months <| floor (Time.inHours time / 24 / 12)
    else
        functions.years <| floor (Time.inHours time / 24 / 365)


defaultSomeSecondsAgo : Int -> String
defaultSomeSecondsAgo seconds =
    if seconds < 30 then
        "just now"
    else
        toString seconds ++ " seconds ago"


defaultSomeMinutesAgo : Int -> String
defaultSomeMinutesAgo minutes =
    if minutes < 2 then
        "a minute ago"
    else
        toString minutes ++ " minutes ago"


defaultSomeHoursAgo : Int -> String
defaultSomeHoursAgo hours =
    if hours < 2 then
        "an hour ago"
    else
        toString hours ++ " hours ago"


defaultSomeDaysAgo : Int -> String
defaultSomeDaysAgo days =
    if days < 2 then
        "yesterday"
    else
        toString days ++ " days ago"


defaultSomeMonthsAgo : Int -> String
defaultSomeMonthsAgo months =
    if months < 2 then
        "last month"
    else
        toString months ++ " months ago"


defaultSomeYearsAgo : Int -> String
defaultSomeYearsAgo years =
    if years < 2 then
        "last year"
    else
        toString years ++ " years ago"


defaultInSomeSeconds : Int -> String
defaultInSomeSeconds seconds =
    if seconds < 30 then
        "in a few seconds"
    else
        "in " ++ toString seconds ++ " seconds"


defaultInSomeMinutes : Int -> String
defaultInSomeMinutes minutes =
    if minutes < 2 then
        "in a minute"
    else
        "in " ++ toString minutes ++ " minutes"


defaultInSomeHours : Int -> String
defaultInSomeHours hours =
    if hours < 2 then
        "in an hour"
    else
        "in " ++ toString hours ++ " hours"


defaultInSomeDays : Int -> String
defaultInSomeDays days =
    if days < 2 then
        "tomorrow"
    else
        "in " ++ toString days ++ " days"


defaultInSomeMonths : Int -> String
defaultInSomeMonths months =
    if months < 2 then
        "in a month"
    else
        "in " ++ toString months ++ " months"


defaultInSomeYears : Int -> String
defaultInSomeYears years =
    if years < 2 then
        "in a year"
    else
        "in " ++ toString years ++ " years"
