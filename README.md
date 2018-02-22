# elm-date-format
> A reliable way to format dates with Elm.

[![Build Status](https://travis-ci.org/RyanNHG/elm-date-format.svg?branch=master)](https://travis-ci.org/RyanNHG/elm-date-format)

### Using the [elm package](http://package.elm-lang.org/packages/ryannhg/elm-date-format/latest)

```
elm package install ryannhg/elm-date-format
```


### What is `elm-date-format`?

If you're coming from Javascript, you might have heard of [MomentJS](https://momentjs.com).

MomentJS is a great library for formatting dates!

`elm-date-format` has the same [formatting options](https://momentjs.com/docs/#/displaying/format/) as Moment, but uses Elm's awesome type system to provide human readable names, and catch typos for you at compile time!

No need to remember the difference between `mm` and `MM` and `M`!


### A quick example

```elm
import Date exposing (Date)
import DateFormat


-- Create a custom formatter

yourFormatter : Date -> String
yourFormatter =
    DateFormat.format
        [ DateFormat.monthNameFull
        , DateFormat.text " "
        , DateFormat.dayOfMonthSuffix
        , DateFormat.text ", "
        , DateFormat.yearNumber
        ]


-- Using your formatter, format your date as a string!

yourPrettyDate : String
yourPrettyDate =
    case Date.fromString "2018-02-05T00:00:00.000" of
        Ok date ->
            yourFormatter date

        Err ->
            "This shouldn't happen..."

```

Would make `yourPrettyDate` return:

```
"February 5th, 2018" : String
```
