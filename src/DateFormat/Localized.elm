module DateFormat.Localized exposing (spanish)

{-| Format dates in your language!

@docs spanish, french, portuguese, greek

-}

import DateFormat exposing (FormatOptions)
import Time exposing (Month(..), Weekday(..))


{-| Spanish localization.
-}
spanish : FormatOptions
spanish =
    { fullMonthName =
        \month ->
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
    , dayOfWeekName =
        \weekday ->
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
    }


{-| French localization
-}
french : FormatOptions
french =
    { fullMonthName =
        \month ->
            case month of
                Jan ->
                    "Janvier"

                Feb ->
                    "Février"

                Mar ->
                    "Mars"

                Apr ->
                    "Avril"

                May ->
                    "Mai"

                Jun ->
                    "Juin"

                Jul ->
                    "Juillet"

                Aug ->
                    "Août"

                Sep ->
                    "Septembre"

                Oct ->
                    "Octobre"

                Nov ->
                    "Novembre"

                Dec ->
                    "Décembre"
    , dayOfWeekName =
        \weekday ->
            case weekday of
                Mon ->
                    "Lundi"

                Tue ->
                    "Mardi"

                Wed ->
                    "Mercredi"

                Thu ->
                    "Jeudi"

                Fri ->
                    "Vendredi"

                Sat ->
                    "Samedi"

                Sun ->
                    "Dimanche"
    }


{-| Portugeuse (and Brazillian) localization.
-}
portuguese : FormatOptions
portuguese =
    { fullMonthName =
        \month ->
            case month of
                Jan ->
                    "Janeiro"

                Feb ->
                    "Fevereiro"

                Mar ->
                    "Março"

                Apr ->
                    "Abril"

                May ->
                    "Maio"

                Jun ->
                    "Junho"

                Jul ->
                    "Julho"

                Aug ->
                    "Agosto"

                Sep ->
                    "Setembro"

                Oct ->
                    "Outubro"

                Nov ->
                    "Novembro"

                Dec ->
                    "Dezembro"
    , dayOfWeekName =
        \weekday ->
            case weekday of
                Mon ->
                    "Segunda-feira"

                Tue ->
                    "Terça-feira"

                Wed ->
                    "Quarta-feira"

                Thu ->
                    "Quinta-feira"

                Fri ->
                    "Sexta-feira"

                Sat ->
                    "Sábado"

                Sun ->
                    "Domingo"
    }


{-| Greek localization.
-}
greek : FormatOptions
greek =
    { fullMonthName =
        \month ->
            case month of
                Jan ->
                    "Ιανουαρίου"

                Feb ->
                    "Φεβρουαρίου"

                Mar ->
                    "Μαρτίου"

                Apr ->
                    "Απριλίου"

                May ->
                    "Μαΐου"

                Jun ->
                    "Ιουνίου"

                Jul ->
                    "Ιουλίου"

                Aug ->
                    "Αυγούστου"

                Sep ->
                    "Σεπτεμβρίου"

                Oct ->
                    "Οκτωβρίου"

                Nov ->
                    "Νοεμβρίου"

                Dec ->
                    "Δεκεμβρίου"
    , dayOfWeekName =
        \weekday ->
            case weekday of
                Mon ->
                    "Δευτέρα"

                Tue ->
                    "Τρίτη"

                Wed ->
                    "Τετάρτη"

                Thu ->
                    "Πέμπτη"

                Fri ->
                    "Παρασκευή"

                Sat ->
                    "Σάββατο"

                Sun ->
                    "Κυριακή"
    }
