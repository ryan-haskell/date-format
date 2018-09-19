module Relative exposing (main)

import Browser
import DateFormat.Relative as Relative
import Html exposing (..)
import Task
import Time exposing (Posix, Zone, utc)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { timeSinceExample : Posix
    , initialTime : Maybe Posix
    , now : Maybe Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        (Time.millisToPosix 1526852818792)
        Nothing
        Nothing
    , Task.perform SetInitialTime Time.now
    )


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Model" ]
        , p [] [ text <| Debug.toString model ]
        , case ( model.initialTime, model.now ) of
            ( Just initialTime, Just now ) ->
                p []
                    [ strong [] [ text "Time since you loaded this page: " ]
                    , span [] [ text <| Relative.relativeTime now initialTime ]
                    ]

            ( _, _ ) ->
                p [] [ text "Getting times..." ]
        , case model.now of
            Just now ->
                p []
                    [ strong [] [ text "Time since Ryan wrote this example: " ]
                    , span [] [ text <| Relative.relativeTime now model.timeSinceExample ]
                    ]

            Nothing ->
                p [] [ text "Getting now time..." ]
        ]


type Msg
    = SetInitialTime Posix
    | SetNow Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetInitialTime initialTime ->
            ( { model
                | initialTime = Just initialTime
                , now = Just initialTime
              }
            , Cmd.none
            )

        SetNow now ->
            ( { model | now = Just now }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 SetNow
