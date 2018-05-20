# date-format
> A reliable way to format dates and times with Elm.

[![Build Status](https://travis-ci.org/ryannhg/elm-date-format.svg?branch=master)](https://travis-ci.org/ryannhg/elm-date-format)

### Using the [elm package](http://package.elm-lang.org/packages/ryannhg/date-format/latest)

```
elm package install ryannhg/date-format
```


### What is `date-format`?

If you're coming from Javascript, you might have heard of [MomentJS](https://momentjs.com).

MomentJS is a great library for formatting dates!

`date-format` has similar [formatting options](https://momentjs.com/docs/#/displaying/format/) as Moment, but uses Elm's awesome type system to provide human readable names, and catch typos for you at compile time!

No need to remember the difference between `mm` and `MM` and `M`!


### A quick example

```elm
import DateFormat
import Time exposing (Zone, Posix)


-- Let's create a custom formatter we can use later:

ourFormatter : Zone -> Prefix -> String
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

```

Would make `ourPrettyDate` return:

```
"May 20th, 2018" : String
```
