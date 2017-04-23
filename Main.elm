{- This file re-implements the Elm Counter example (1 counter) with elm-mdl
   buttons. Use this as a starting point for using elm-mdl components in your own
   app.
-}


module Main exposing (..)

import Html exposing (..)
import Hexagram exposing (Hexagram, hexagramList)
import Html.Attributes exposing (href, class, style)
import Markdown
import Material
import Material.Textfield as Textfield
import Material.Scheme
import Material.Color as Color
import Material.Button as Button
import Material.Options as Options exposing (css)



-- MODEL


type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
  let defaultContent = 
        [ Textfield.render Mdl [0] model.mdl [ Textfield.label "Enter a Question" , Textfield.floatingLabel , Textfield.textarea, css "width" "100%" ] []
        , Button.render Mdl [1] model.mdl [Options.onClick Increase] [text "Ask"]
        ]
  in
  let content = defaultContent ++ case List.head hexagramList of
    Nothing -> []
    Just hex -> [Hexagram.renderReading hex hex]
  in
    div
        [ style [ ( "padding", "2rem" ) ] ]
        content
        |> Material.Scheme.topWithScheme Color.Blue Color.Purple


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
      }
