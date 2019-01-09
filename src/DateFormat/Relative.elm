module DateFormat.Relative exposing (relativeTime, relativeTimeWithOptions)

{-| A reliable way to get a pretty message for the relative time difference between two dates.


# Getting relative time for two dates

@docs relativeTime, relativeTimeWithOptions

-}

import DateFormat.Relative.Language exposing (RelativeTimeOptions)
import Time exposing (Month(..), Posix, Weekday(..), Zone, utc)


{-| This function takes in two times and returns the relative difference!

Here are a few examples to help:

    relativeTime now tenSecondsAgo == "just now"

    relativeTime now tenSecondsFromNow == "in a few seconds"

    relativeTime now fortyThreeMinutesAgo == "43 minutes ago"

    relativeTime now oneHundredDaysAgo == "100 days ago"

    relativeTime now oneHundredDaysFromNow == "in 100 days"

    -- Order matters!
    relativeTime now tenSecondsAgo == "just now"

    relativeTime tenSecondsAgo now == "in a few seconds"

-}
relativeTime : Posix -> Posix -> String
relativeTime =
    relativeTimeWithOptions DateFormat.Relative.Language.english


{-| Maybe `relativeTime` is too lame. (Or maybe you speak a different language than English!)

With `relativeTimeWithOptions`, you can use one of the predefined options in
`DateFormat.Relative.Language` or even provide your own custom messages for each time range.

That's what `relativeTime` does: it uses the `english` options under the hood!

You can provide a set of your own custom options, and use `relativeTimeWithOptions` instead.

-}
relativeTimeWithOptions : RelativeTimeOptions -> Posix -> Posix -> String
relativeTimeWithOptions options start end =
    let
        differenceInMilliseconds : Int
        differenceInMilliseconds =
            toMilliseconds end - toMilliseconds start
    in
    if differenceInMilliseconds == 0 then
        options.rightNow

    else
        relativeTimeWithFunctions utc (abs differenceInMilliseconds) <|
            if differenceInMilliseconds < 0 then
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


toMilliseconds : Posix -> Int
toMilliseconds =
    Time.posixToMillis


type alias RelativeTimeFunctions =
    { seconds : Int -> String
    , minutes : Int -> String
    , hours : Int -> String
    , days : Int -> String
    , months : Int -> String
    , years : Int -> String
    }


relativeTimeWithFunctions : Zone -> Int -> RelativeTimeFunctions -> String
relativeTimeWithFunctions zone millis functions =
    let
        posix =
            Time.millisToPosix millis

        seconds =
            millis // 1000

        minutes =
            seconds // 60

        hours =
            minutes // 60

        days =
            hours // 24
    in
    if minutes < 1 then
        functions.seconds <| Time.toSecond zone posix

    else if hours < 1 then
        functions.minutes <| Time.toMinute zone posix

    else if hours < 24 then
        functions.hours <| Time.toHour zone posix

    else if days < 30 then
        functions.days <| days

    else if days < 365 then
        functions.months <| (days // 30)

    else
        functions.years <| (days // 365)
