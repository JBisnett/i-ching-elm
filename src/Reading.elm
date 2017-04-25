module Reading exposing (..)
import Hexagram exposing (..)
import Material
import Material.Textfield as Textfield
import Hexagram exposing (..)

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

type Msg = GetReading String
         | Mdl (Material.Msg Msg)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        GetReading string ->
          let get = lookup hexagramList
              (initialBools, s1) =  Random.step (Random.list 6 <| Random.bool) model.seed
              (movingBools, s2) = Random.step (Random.list 6 <| Random.bool) s1
          in 
            ( { model | initialHexagram = get <| initialBools, movingHexagram = get movingBools, seed = s1}
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model

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
          Nothing -> [Hexagram.toHtml hex]
          Just res -> [Hexagram.renderReading hex res]
  in

