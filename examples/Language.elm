module Language exposing (main)

import Browser exposing (sandbox)
import DateFormat
import DateFormat.Language exposing (Language, spanish)
import Html exposing (div, p, strong, text)
import Time exposing (Month(..), Posix, Weekday(..), Zone, utc)


tokens : List DateFormat.Token
tokens =
    [ DateFormat.monthNameFull
    , DateFormat.text " "
    , DateFormat.dayOfMonthSuffix
    , DateFormat.text ", "
    , DateFormat.yearNumber
    , DateFormat.text " ("
    , DateFormat.dayOfWeekNameFull
    , DateFormat.text ")"
    ]


defaultFormatter : Zone -> Posix -> String
defaultFormatter =
    DateFormat.format tokens


spanishFormatter : Zone -> Posix -> String
spanishFormatter =
    DateFormat.formatWithLanguage spanish tokens



-- With our formatter, we can format any date as a string!


ourTimezone : Zone
ourTimezone =
    utc



-- 2018-05-20T19:18:24.911Z


ourPosixTime : Posix
ourPosixTime =
    Time.millisToPosix 1526843861289


ourDefaultDate : String
ourDefaultDate =
    defaultFormatter ourTimezone ourPosixTime


ourSpanishDate : String
ourSpanishDate =
    spanishFormatter ourTimezone ourPosixTime



-- Show on the screen


main =
    sandbox
        { init = Nothing
        , update = \_ _ -> Nothing
        , view =
            \_ ->
                div []
                    [ p []
                        [ strong [] [ text "Default: " ]
                        , text ourDefaultDate
                        ]
                    , p []
                        [ strong [] [ text "Spanish: " ]
                        , text ourSpanishDate
                        ]
                    ]
        }
