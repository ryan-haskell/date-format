# Changelog
> Detailed information about changes from minor and major releases.

If you'd like to see differences between your version and the one you want to upgrade, you can run:

`elm diff ryannhg/date-format <version> <another-version>`

---

### `2.3.0`

This is a MINOR change.

#### DateFormat.Language - MINOR

    Added:
        portuguese : DateFormat.Language.Language

---

### `2.2.0`

This is a MINOR change.

#### DateFormat.Language - MINOR

    Added:
        swedish : DateFormat.Language.Language

---

### `2.1.0`

This is a MINOR change.

#### DateFormat.Language - MINOR

    Added:
        dutch : DateFormat.Language.Language

---

### `2.0.0`
This is a MAJOR change.

#### ADDED MODULES - MINOR

    DateFormat.Language


#### DateFormat - MAJOR

    Added:
        dayOfWeekNameAbbreviated : Token
        formatWithLanguage : Language -> List Token -> Zone -> Posix -> String
        millisecondFixed : Token
        millisecondNumber : Token
        monthNameAbbreviated : Token

    Removed:
        type alias FormatOptions =
            { fullMonthName : Month -> String, dayOfWeekName : Weekday -> String
            }
        dayOfWeekNameFirstThree : Token
        dayOfWeekNameFirstTwo : Token
        formatWithOptions :
            FormatOptions -> List Token -> Zone -> Posix -> String
        monthNameFirstThree : Token


#### DateFormat.Relative - MINOR

    Added:
        defaultRelativeOptions : RelativeTimeOptions

---
