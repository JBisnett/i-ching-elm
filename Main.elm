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
import Material.Layout as Layout



-- MODEL


type alias Model =
    { initialHexagram : Maybe Hexagram
    , movingHexagram : Maybe Hexagram
    , mdl : Material.Model
    }


model : Model
model =
    { initialHexagram = Nothing
    , movingHexagram = Nothing
    , mdl = Material.model
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
            ( { model | initialHexagram = List.head hexagramList}
            , Cmd.none
            )

        Reset ->
            ( { model | initialHexagram = Nothing }
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
  let content = defaultContent ++ 
      case model.initialHexagram of
        Nothing -> []
        Just hex -> [Hexagram.toHtml hex]
  in
     Layout.render Mdl model.mdl
     [ 
       Layout.waterfall True
     ]
     { header = [
       Layout.row [] []
       ]
     , drawer = [
       ]
     , tabs = ( []
              , [])
     , main = [ 
       div [ style [ ( "padding", "2rem" ) ] ] content
     ] 
     }
     |> Material.Scheme.topWithScheme Color.LightBlue Color.Purple


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
      }
