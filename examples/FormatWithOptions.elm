module Basic exposing (..)

import Browser exposing (staticPage)
import DateFormat
import Html exposing (div, p, strong, text)
import Time exposing (Month(..), Posix, Weekday(..), Zone, utc)


-- Let's try out spanish instead!


spanishFullMonthName : Time.Month -> String
spanishFullMonthName month =
    case month of
        Jan ->
            "Enero"

        Feb ->
            "Febrero"

        Mar ->
            "Marzo"

        Apr ->
            "Abril"

        May ->
            "Mayo"

        Jun ->
            "Junio"

        Jul ->
            "Julio"

        Aug ->
            "Agosto"

        Sep ->
            "Septiembre"

        Oct ->
            "Octubre"

        Nov ->
            "Noviembre"

        Dec ->
            "Diciembre"


spanishDayOfWeekName : Time.Weekday -> String
spanishDayOfWeekName weekday =
    case weekday of
        Mon ->
            "Lunes"

        Tue ->
            "Martes"

        Wed ->
            "Miércoles"

        Thu ->
            "Jueves"

        Fri ->
            "Viernes"

        Sat ->
            "Sábado"

        Sun ->
            "Domingo"


spanishOptions : DateFormat.FormatOptions
spanishOptions =
    { fullMonthName = spanishFullMonthName
    , dayOfWeekName = spanishDayOfWeekName
    }



-- Let's put it next to `format` for comparison:


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
    DateFormat.formatWithOptions spanishOptions tokens



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
    staticPage
        (div []
            [ p []
                [ strong [] [ text "Default: " ]
                , text ourDefaultDate
                ]
            , p []
                [ strong [] [ text "Spanish: " ]
                , text ourSpanishDate
                ]
            ]
        )
