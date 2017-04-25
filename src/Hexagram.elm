module Hexagram exposing (..)
import Html exposing (..)
import Material.Card as Card
import Material.Grid exposing (grid, cell, size, offset,  Device(..))
import Material.Color as Color
import Material.Options as Options exposing (css)
import Material.Elevation as Elevation
import HtmlParser as Parser
type alias Hexagram = 
  { number: Int
  , name: String
  , descriptor: String
  , directName: String
  , character: String
  , image: String
  , judgement: String
  , lines: List String
  , bars: List Bool
  }

basicCard: Hexagram -> List (Card.Block msg)
basicCard hex = 
    [ Card.title [] [Card.head [] [text hex.character], Card.subhead [] [text hex.name]]
    , Card.text [] 
      [ h4 [] [text "Judgement"]
      , p [] [text hex.judgement]
      ]
    , Card.text [] 
      [ h4 [] [text "Image"]
      , p [] [text hex.image]
      ]
    ]

renderAll: List Hexagram -> Html msg
renderAll hexs = 
  let cf hex = Card.view [Elevation.e8, Color.background Color.primary, Color.text Color.primaryContrast] <| basicCard hex
  in
  Options.div [Options.center] <| List.map cf hexs

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  let barXor = List.map2 xor sgram.bars mgram.bars
      lines op lns =
      [ Card.text [] [text "Lines"]
      , Card.text [] [ol [] (List.map2 (\line change -> li [] [if change then op <| text line else text line]) lns barXor)]
      ]
    in
  Options.div []
    [ Card.view [] (basicCard sgram ++ (lines <| del [] << List.singleton) sgram.lines)
    , Card.view [] (basicCard mgram ++ (lines <| del [] << List.singleton) sgram.lines)
    ]
view: Hexagram -> Html msg
view hex = Card.view [] <| basicCard hex
