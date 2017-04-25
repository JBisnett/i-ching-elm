module Main exposing (..)

import Html exposing (..)
import Random
import Hexagram exposing (Hexagram)
import HexagramList exposing (hexagramList)
import Html.Attributes exposing (href, class, style)
import Markdown
import Material
import Material.Textfield as Textfield
import Material.Scheme
import Material.Color as Color
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout

import HtmlParser as Parser


-- MODEL


type alias Model =
    { initialHexagram : Maybe Hexagram
    , movingHexagram : Maybe Hexagram
    , seed : Random.Seed
    , mdl : Material.Model
    }


model : Model
model =
    { initialHexagram = Nothing
    , movingHexagram = Nothing
    , seed = Random.initialSeed 1
    , mdl = Material.model
    }

-- ACTION, UPDATE


type Msg
    = GetReading
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetReading ->
          let get = lookup hexagramList
              (coins, s1) =  Random.step (Random.list 6 <| Random.list 3 <| Random.bool) model.seed
              getVal l = 
                case List.length <| List.filter ((==) True) l of
                  0 -> (False, True)
                  1 -> (False, False)
                  2 -> (True, True)
                  3 -> (True, False)
                  _ -> (True, True) -- shouldn't happen
              (initialBools, movingBools) = List.unzip <| List.map getVal coins 
          in 
            ( { model | initialHexagram = get <| initialBools, movingHexagram = get movingBools, seed = s1}
            , Cmd.none
            )

        Reset ->
            ( { model | initialHexagram = Nothing, movingHexagram = Nothing, seed = Random.initialSeed 1 }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model

lookup : List Hexagram -> List Bool -> Maybe Hexagram
lookup hexs bools = 
  case hexs of
    [] -> Nothing
    h::hs -> if [True, True, True, True, True, True] == List.map2 (==) bools h.bars 
                then Just h 
                else lookup hs bools  

view : Model -> Html Msg
view model =
  let defaultContent = 
        [ Textfield.render Mdl [0] model.mdl [ Textfield.label "Enter a Question" , Textfield.floatingLabel , Textfield.textarea, css "width" "100%" ] []
        , Button.render Mdl [1] model.mdl [Options.onClick GetReading] [text "Ask"]
        ]
  in
  let content = defaultContent ++ 
      case model.initialHexagram of
        Nothing -> [Hexagram.renderAll hexagramList]
        Just hex -> case model.movingHexagram of
          Nothing -> [Hexagram.view hex]
          Just res -> [Hexagram.renderReading hex res]
  in
     Layout.render Mdl model.mdl
     [ 
       Layout.waterfall True
     ]
     { header = [
       Layout.row [] [h4 [] [text "I Ching"]]
       ]
     , drawer = [
       ]
     , tabs = ( []
              , [])
     , main = [ 
       div [ style [ ( "padding", "2rem" ) ] ] content
     ] 
     }
     |> Material.Scheme.topWithScheme Color.Blue Color.Purple


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
      }
