module DateFormat.Relative.Language exposing
    ( RelativeTimeOptions
    , english, finnish
    )

{-|


## Fun fact: Some people don't know english.

That's why it's important to include alternative date formatting options for other languages!

This module exposes implementations of `RelativeTimeOptions`, for different languages.

(If you want to see `french`, `german`, or `greek`, please add them in! I'm happy to make your language a part of the package!)


### Options

@docs RelativeTimeOptions


### Languages

@docs english, finnish

-}


{-| Options for configuring your own relative message formats!

For example, here is how `someSecondsAgo` is implemented for English:

    englishSomeSecondsAgo : Int -> String
    englishSomeSecondsAgo seconds =
        if seconds < 30 then
            "just now"

        else
            toString seconds ++ " seconds ago"

And here is how `inSomeHours` might look:

    englishInSomeHours : Int -> String
    englishInSomeHours hours =
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
    , rightNow : String
    , inSomeSeconds : Int -> String
    , inSomeMinutes : Int -> String
    , inSomeHours : Int -> String
    , inSomeDays : Int -> String
    , inSomeMonths : Int -> String
    , inSomeYears : Int -> String
    }



-- English


{-| English language options (the default)
-}
english : RelativeTimeOptions
english =
    { someSecondsAgo = englishSomeSecondsAgo
    , someMinutesAgo = englishSomeMinutesAgo
    , someHoursAgo = englishSomeHoursAgo
    , someDaysAgo = englishSomeDaysAgo
    , someMonthsAgo = englishSomeMonthsAgo
    , someYearsAgo = englishSomeYearsAgo
    , rightNow = englishRightNow
    , inSomeSeconds = englishInSomeSeconds
    , inSomeMinutes = englishInSomeMinutes
    , inSomeHours = englishInSomeHours
    , inSomeDays = englishInSomeDays
    , inSomeMonths = englishInSomeMonths
    , inSomeYears = englishInSomeYears
    }


englishRightNow : String
englishRightNow =
    "right now"


englishSomeSecondsAgo : Int -> String
englishSomeSecondsAgo seconds =
    if seconds < 30 then
        "just now"

    else
        String.fromInt seconds ++ " seconds ago"


englishSomeMinutesAgo : Int -> String
englishSomeMinutesAgo minutes =
    if minutes < 2 then
        "a minute ago"

    else
        String.fromInt minutes ++ " minutes ago"


englishSomeHoursAgo : Int -> String
englishSomeHoursAgo hours =
    if hours < 2 then
        "an hour ago"

    else
        String.fromInt hours ++ " hours ago"


englishSomeDaysAgo : Int -> String
englishSomeDaysAgo days =
    if days < 2 then
        "yesterday"

    else
        String.fromInt days ++ " days ago"


englishSomeMonthsAgo : Int -> String
englishSomeMonthsAgo months =
    if months < 2 then
        "last month"

    else
        String.fromInt months ++ " months ago"


englishSomeYearsAgo : Int -> String
englishSomeYearsAgo years =
    if years < 2 then
        "last year"

    else
        String.fromInt years ++ " years ago"


englishInSomeSeconds : Int -> String
englishInSomeSeconds seconds =
    if seconds < 30 then
        "in a few seconds"

    else
        "in " ++ String.fromInt seconds ++ " seconds"


englishInSomeMinutes : Int -> String
englishInSomeMinutes minutes =
    if minutes < 2 then
        "in a minute"

    else
        "in " ++ String.fromInt minutes ++ " minutes"


englishInSomeHours : Int -> String
englishInSomeHours hours =
    if hours < 2 then
        "in an hour"

    else
        "in " ++ String.fromInt hours ++ " hours"


englishInSomeDays : Int -> String
englishInSomeDays days =
    if days < 2 then
        "tomorrow"

    else
        "in " ++ String.fromInt days ++ " days"


englishInSomeMonths : Int -> String
englishInSomeMonths months =
    if months < 2 then
        "in a month"

    else
        "in " ++ String.fromInt months ++ " months"


englishInSomeYears : Int -> String
englishInSomeYears years =
    if years < 2 then
        "in a year"

    else
        "in " ++ String.fromInt years ++ " years"



-- Finnish


{-| Finnish language options
-}
finnish : RelativeTimeOptions
finnish =
    { someSecondsAgo = finnishSomeSecondsAgo
    , someMinutesAgo = finnishSomeMinutesAgo
    , someHoursAgo = finnishSomeHoursAgo
    , someDaysAgo = finnishSomeDaysAgo
    , someMonthsAgo = finnishSomeMonthsAgo
    , someYearsAgo = finnishSomeYearsAgo
    , rightNow = finnishRightNow
    , inSomeSeconds = finnishInSomeSeconds
    , inSomeMinutes = finnishInSomeMinutes
    , inSomeHours = finnishInSomeHours
    , inSomeDays = finnishInSomeDays
    , inSomeMonths = finnishInSomeMonths
    , inSomeYears = finnishInSomeYears
    }


finnishRightNow : String
finnishRightNow =
    "juuri nyt"


finnishSomeSecondsAgo : Int -> String
finnishSomeSecondsAgo seconds =
    if seconds < 30 then
        "juuri äsken"

    else
        String.fromInt seconds ++ " sekuntia sitten"


finnishSomeMinutesAgo : Int -> String
finnishSomeMinutesAgo minutes =
    if minutes < 2 then
        "minuutti sitten"

    else
        String.fromInt minutes ++ " minuuttia sitten"


finnishSomeHoursAgo : Int -> String
finnishSomeHoursAgo hours =
    if hours < 2 then
        "tunti sitten"

    else
        String.fromInt hours ++ " tuntia sitten"


finnishSomeDaysAgo : Int -> String
finnishSomeDaysAgo days =
    if days < 2 then
        "eilen"

    else if days < 2 then
        "toissapäivänä"

    else
        String.fromInt days ++ " päivää sitten"


finnishSomeMonthsAgo : Int -> String
finnishSomeMonthsAgo months =
    if months < 2 then
        "kuukausi sitten"

    else
        String.fromInt months ++ " kuukautta sitten"


finnishSomeYearsAgo : Int -> String
finnishSomeYearsAgo years =
    if years < 2 then
        "vuosi sitten"

    else
        String.fromInt years ++ " vuotta sitten"


finnishInSomeSeconds : Int -> String
finnishInSomeSeconds seconds =
    (if seconds < 30 then
        "muutaman"

     else
        String.fromInt seconds
    )
        ++ " sekunnin kuluttua"


finnishInSomeMinutes : Int -> String
finnishInSomeMinutes minutes =
    if minutes < 2 then
        "minuutin kuluttua"

    else
        String.fromInt minutes ++ " minuutin kuluttua"


finnishInSomeHours : Int -> String
finnishInSomeHours hours =
    if hours < 2 then
        "tunnin kuluttua"

    else
        String.fromInt hours ++ " tunnin kuluttua"


finnishInSomeDays : Int -> String
finnishInSomeDays days =
    if days < 2 then
        "huomenna"

    else if days < 3 then
        "ylihuomenna"

    else
        String.fromInt days ++ " päivän kuluttua"


finnishInSomeMonths : Int -> String
finnishInSomeMonths months =
    if months < 2 then
        "kuukauden kuluttua"

    else
        String.fromInt months ++ " kuukauden kuluttua"


finnishInSomeYears : Int -> String
finnishInSomeYears years =
    if years < 2 then
        "ensi vuonna"

    else
        String.fromInt years ++ " vuoden kuluttua"
