module Basic exposing (main)

import Browser exposing (sandbox)
import DateFormat
import Html exposing (text)
import Time exposing (Posix, Zone, utc)



-- Let's create a custom formatter we can use later:


ourFormatter : Zone -> Posix -> String
ourFormatter =
    DateFormat.format
        [ DateFormat.monthNameFull
        , DateFormat.text " "
        , DateFormat.dayOfMonthSuffix
        , DateFormat.text ", "
        , DateFormat.yearNumber
        ]



-- With our formatter, we can format any date as a string!


ourTimezone : Zone
ourTimezone =
    utc



-- 2018-05-20T19:18:24.911Z


ourPosixTime : Posix
ourPosixTime =
    Time.millisToPosix 1526843861289


ourPrettyDate : String
ourPrettyDate =
    ourFormatter ourTimezone ourPosixTime



-- Show on the screen


main =
    sandbox
        { init = Nothing
        , update = \_ _ -> Nothing
        , view = \_ -> text ourPrettyDate
        }
