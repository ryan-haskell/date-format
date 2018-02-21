module DateFormat
    exposing
        ( Token(..)
        , format
        )

{-| A reliable way to format dates with elm


# The `format` function

@docs format


# Available formatting options

@docs Token

-}

import Date exposing (Date, Month(..), Day(..))


{-| These are the available tokens to help you format dates.


## Month

**`MonthNumber`** - `1, 2, 3, ... 11, 12`

**`MonthSuffix`** - `1st, 2nd, 3rd, ... 11th, 12th`

**`MonthFixed`** - `01, 02, 03, ... 11, 12`

**`MonthNameFirstThree`** - `Jan, Feb, Mar, ... Nov, Dec`

**`MonthNameFull`** - `January, February, ... December`

---


## Day of the Month

**`DayOfMonthNumber`** - `1, 2, 3, ... 30, 31`

**`DayOfMonthSuffix`** - `1st, 2nd, 3rd, ... 30th, 31st`

**`DayOfMonthFixed`** - `01, 02, 03, ... 30, 31`

---


## Day of the Year

**`DayOfYearNumber`** - `1, 2, 3, ... 364, 365`

**`DayOfYearSuffix`** - `1st, 2nd, 3rd, ... 364th, 365th`

**`DayOfYearFixed`** - `001, 002, 003, ... 364, 365`

---


## Day of the Week

**`DayOfWeekNumber`** - `0, 1, 2, ... 5, 6`

**`DayOfWeekSuffix`** - `0th, 1st, 2nd, ... 5th, 6th`

**`DayOfWeekNameFirstTwo`** - `Su, Mo, Tue, ... Fr, Sa`

**`DayOfWeekNameFirstThree`** - `Sun, Mon, Tue, ... Fri, Sat`

**`DayOfWeekNameFull`** - `Sunday, Monday, ... Friday, Saturday`

---


## Year

**`YearNumberLastTwo`** - `70, 71, ... 29, 30`

**`YearNumberCapped`** - `1970, 1971, ... 2029, 2030`

**`YearNumber`** - `70, 71, ... 9999, ...`

---


## Quarter of the Year

**`QuarterNumber`** - `1, 2, 3, 4`

**`QuarterSuffix`** - `1st, 2nd, 3rd, 4th`

---


## Week of the Year

**`WeekOfYearNumber`** - `1, 2, 3, ... 51, 52`

**`WeekOfYearSuffix`** - `1st, 2nd, 3rd, ... 51st, 52nd`

**`WeekOfYearFixed`** - `01, 02, 03, ... 51, 52`

---


## AM / PM

**`AmPmUppercase`** - `AM, PM`

**`AmPmLowercase`** - `am, pm`

---


## Hour

**`HourMilitaryNumber`** - `0, 1, 2, ... 22, 23`

**`HourMilitaryFixed`** - `00, 01, 02, ... 22, 23`

**`HourNumber`** - `0, 1, 2, ... 11, 12`

**`HourFixed`** - `00, 01, 02, ... 11, 12`

**`HourMilitaryFromOneNumber`** - `1, 2, ... 23, 24`

**`HourMilitaryFromOneFixed`** - `01, 02, ... 23, 24`

---


## Minute

**`MinuteNumber`** - `0, 1, 2, ... 58, 59`

**`MinuteFixed`** - `00, 01, 02, ... 58, 59`

---


## Second

**`SecondNumber`** - `0, 1, 2, ... 58, 59`

**`SecondFixed`** - `00, 01, 02, ... 58, 59`

-}
type Token
    = MonthNumber
    | MonthSuffix
    | MonthFixed
    | MonthNameFirstThree
    | MonthNameFull
    | DayOfMonthNumber
    | DayOfMonthSuffix
    | DayOfMonthFixed
    | DayOfYearNumber
    | DayOfYearSuffix
    | DayOfYearFixed
    | DayOfWeekNumber
    | DayOfWeekSuffix
    | DayOfWeekNameFirstTwo
    | DayOfWeekNameFirstThree
    | DayOfWeekNameFull
    | YearNumberLastTwo
    | YearNumberCapped
    | YearNumber
    | QuarterNumber
    | QuarterSuffix
    | WeekOfYearNumber
    | WeekOfYearSuffix
    | WeekOfYearFixed
    | AmPmUppercase
    | AmPmLowercase
    | HourMilitaryNumber
    | HourMilitaryFixed
    | HourNumber
    | HourFixed
    | HourMilitaryFromOneNumber
    | HourMilitaryFromOneFixed
    | MinuteNumber
    | MinuteFixed
    | SecondNumber
    | SecondFixed
    | Text String


{-| This function takes in a list of tokens and a date to create your formatted string!

Let's say `someDate` is on November 15, 1993 at 15:06.

    -- "15:06"
    format
        [ HourMilitaryFixed
        , Text ":"
        , MinuteFixed
        ]
        someDate

    -- "3:06 pm"
    format
        [ HourNumber
        , Text ":"
        , MinuteFixed
        , Text " "
        , AmPmLowercase
        ]
        someDate

    -- "Nov 15th, 1993"
    format
        [ MonthNameFirstThree
        , Text " "
        , DayOfMonthSuffix
        , Text ", "
        , YearNumber
        ]
        someDate

-}
format : List Token -> Date -> String
format tokens date =
    tokens
        |> List.map (piece date)
        |> String.join ""


{-| Months of the year, in the correct order.
-}
months : List Month
months =
    [ Jan
    , Feb
    , Mar
    , Apr
    , May
    , Jun
    , Jul
    , Aug
    , Sep
    , Nov
    , Dec
    ]


{-| Days of the week, in the correct order.
-}
days : List Day
days =
    [ Sun
    , Mon
    , Tue
    , Wed
    , Thu
    , Fri
    , Sat
    ]


piece : Date -> Token -> String
piece date token =
    case token of
        MonthNumber ->
            monthNumber date
                |> toString

        MonthSuffix ->
            monthNumber date
                |> toSuffix

        MonthFixed ->
            monthNumber date
                |> toFixedLength

        MonthNameFirstThree ->
            Date.month date
                |> toString

        MonthNameFull ->
            fullMonthName date

        QuarterNumber ->
            quarter date
                |> toString

        QuarterSuffix ->
            quarter date
                |> toSuffix

        DayOfMonthNumber ->
            dayOfMonth date
                |> toString

        DayOfMonthSuffix ->
            dayOfMonth date
                |> toSuffix

        DayOfMonthFixed ->
            dayOfMonth date
                |> toFixedLength

        DayOfYearNumber ->
            dayOfYear date
                |> toString

        DayOfYearSuffix ->
            dayOfYear date
                |> toSuffix

        DayOfYearFixed ->
            dayOfYear date
                |> toFixedLength

        DayOfWeekNumber ->
            dayOfWeek date
                |> toString

        DayOfWeekSuffix ->
            dayOfWeek date
                |> toSuffix

        DayOfWeekNameFirstTwo ->
            dayOfWeekName date
                |> String.left 2

        DayOfWeekNameFirstThree ->
            dayOfWeekName date
                |> String.left 3

        DayOfWeekNameFull ->
            dayOfWeekName date

        WeekOfYearNumber ->
            weekOfYear date
                |> toString

        WeekOfYearSuffix ->
            weekOfYear date
                |> toSuffix

        WeekOfYearFixed ->
            weekOfYear date
                |> toFixedLength

        YearNumberLastTwo ->
            year date
                |> String.right 2

        YearNumberCapped ->
            year date

        YearNumber ->
            year date

        AmPmUppercase ->
            amPm date
                |> String.toUpper

        AmPmLowercase ->
            amPm date
                |> String.toLower

        HourMilitaryNumber ->
            Date.hour date
                |> toString

        HourMilitaryFixed ->
            Date.hour date
                |> toFixedLength

        HourNumber ->
            Date.hour date
                |> toNonMilitary
                |> toString

        HourFixed ->
            Date.hour date
                |> toNonMilitary
                |> toFixedLength

        HourMilitaryFromOneNumber ->
            Date.hour date
                |> (+) 1
                |> toString

        HourMilitaryFromOneFixed ->
            Date.hour date
                |> (+) 1
                |> toFixedLength

        MinuteNumber ->
            Date.minute date
                |> toString

        MinuteFixed ->
            Date.minute date
                |> toFixedLength

        SecondNumber ->
            Date.second date
                |> toString

        SecondFixed ->
            Date.second date
                |> toFixedLength

        Text string ->
            string



-- | FractionalSecond Int
-- | UnixTimestamp
-- | UnixMillisecondTimestamp
-- | PlainText String
-- MONTHS


monthPair : Date -> ( Int, Month )
monthPair date =
    months
        |> List.indexedMap (,)
        |> List.filter (\( i, m ) -> m == Date.month date)
        |> List.head
        |> Maybe.withDefault ( 0, Jan )


monthNumber : Date -> Int
monthNumber date =
    monthPair date
        |> (\( i, m ) -> i)
        |> (+) 1


fullMonthName : Date -> String
fullMonthName date =
    case Date.month date of
        Jan ->
            "January"

        Feb ->
            "February"

        Mar ->
            "March"

        Apr ->
            "April"

        May ->
            "May"

        Jun ->
            "June"

        Jul ->
            "July"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "October"

        Nov ->
            "November"

        Dec ->
            "December"


daysInMonth : Int -> Month -> Int
daysInMonth year month =
    case month of
        Jan ->
            31

        Feb ->
            if year % 4 == 0 then
                29
            else
                28

        Mar ->
            31

        Apr ->
            30

        May ->
            31

        Jun ->
            30

        Jul ->
            31

        Aug ->
            31

        Sep ->
            30

        Oct ->
            31

        Nov ->
            30

        Dec ->
            31



-- QUARTERS


quarter : Date -> Int
quarter date =
    (monthNumber date) // 4



-- DAY OF MONTH


dayOfMonth : Date -> Int
dayOfMonth =
    Date.day



-- DAY OF YEAR


dayOfYear : Date -> Int
dayOfYear date =
    let
        monthsBeforeThisOne : List Month
        monthsBeforeThisOne =
            List.take (monthNumber date) months

        daysBeforeThisMonth : Int
        daysBeforeThisMonth =
            monthsBeforeThisOne
                |> List.map (daysInMonth (Date.year date))
                |> List.sum
    in
        daysBeforeThisMonth + (dayOfMonth date)



-- DAY OF WEEK


dayOfWeek : Date -> Int
dayOfWeek date =
    days
        |> List.indexedMap (,)
        |> List.filter (\( _, d ) -> d == Date.dayOfWeek date)
        |> List.head
        |> Maybe.withDefault ( 0, Sun )
        |> (\( i, d ) -> i)


dayOfWeekName : Date -> String
dayOfWeekName date =
    case Date.dayOfWeek date of
        Mon ->
            "Monday"

        Tue ->
            "Tuesday"

        Wed ->
            "Wednesday"

        Thu ->
            "Thursday"

        Fri ->
            "Friday"

        Sat ->
            "Saturday"

        Sun ->
            "Sunday"



-- WEEK OF YEAR


type alias SimpleDate =
    { month : Month
    , day : Int
    , year : Int
    }


weekOfYear : Date -> Int
weekOfYear date =
    let
        daysSoFar : Int
        daysSoFar =
            dayOfYear date

        firstDay : Date
        firstDay =
            firstDayOfYear date

        firstDayOffset : Int
        firstDayOffset =
            dayOfWeek firstDay
    in
        (daysSoFar + firstDayOffset) // 7 + 1


firstDayOfYear : Date -> Date
firstDayOfYear date =
    case Date.fromString <| (toString (Date.year date)) ++ "-01-01T00:00:00.000Z" of
        Ok date ->
            date

        Err _ ->
            date



-- YEAR


year : Date -> String
year date =
    date
        |> Date.year
        |> toString



-- AM / PM


amPm : Date -> String
amPm date =
    if Date.hour date > 11 then
        "pm"
    else
        "am"



-- HOUR


toNonMilitary : Int -> Int
toNonMilitary num =
    if num == 0 then
        12
    else if num < 12 then
        num
    else
        num - 12



-- GENERIC


toFixedLength : Int -> String
toFixedLength num =
    if num < 10 then
        "0" ++ (toString num)
    else
        toString num


toSuffix : Int -> String
toSuffix num =
    let
        suffix =
            case num of
                11 ->
                    "th"

                12 ->
                    "th"

                13 ->
                    "th"

                _ ->
                    case num % 10 of
                        1 ->
                            "st"

                        2 ->
                            "nd"

                        3 ->
                            "rd"

                        _ ->
                            "th"
    in
        (toString num) ++ suffix
