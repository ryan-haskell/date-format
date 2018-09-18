# date-format
> A reliable way to format dates and times with Elm.

[![Build Status](https://travis-ci.org/ryannhg/date-format.svg?branch=master)](https://travis-ci.org/ryannhg/date-format)


### Using the [elm package](http://package.elm-lang.org/packages/ryannhg/date-format/latest)

```
elm install ryannhg/date-format
```


### What is `date-format`?

If you're coming from Javascript, you might have heard of [MomentJS](https://momentjs.com).

MomentJS is a great library for formatting dates!

`date-format` has similar [formatting options](https://momentjs.com/docs/#/displaying/format/) as Moment, but it uses Elm's awesome type system to provide __human readable__ names, and catch typos for you at compile time!

No need to remember the difference between `mm` and `MM` and `M`!


### A quick example

```elm
import DateFormat
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

```

Would make `ourPrettyDate` return:

```
"May 20th, 2018" : String
```

### Want more examples?

I've created a few more examples in the `examples/` folder for this repo.

Here's how you can try them out:

1. `git clone https://github.com/ryannhg/date-format`

1. `cd date-format/examples`

1. `elm reactor`

1. Go to [http://localhost:8000](http://localhost:8000)




