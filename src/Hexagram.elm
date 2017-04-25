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
    [ Card.title [Color.text Color.primaryContrast] [Card.head [] [h1 [] [text hex.character]], Card.subhead [] [h2 [] [text hex.name]]]
    , Card.text [Color.text Color.primaryContrast] 
      [ h4 [] [text "Judgement"]
      , p [] [text hex.judgement]
      ]
    , Card.text [Color.text Color.primaryContrast] 
      [ h4 [] [text "Image"]
      , p [] [text hex.image]
      ]
    ]

renderAll: List Hexagram -> Html msg
renderAll hexs = 
  let cf hex = cell [] <| List.singleton <| Card.view [Elevation.e8, Color.background Color.primary, Color.text Color.primaryContrast] <| basicCard hex
      ++ [Card.text [Color.text Color.primaryContrast] [text "Lines"], Card.text [Color.text Color.primaryContrast] [ol [] <| List.map (\line -> li [] [text line]) hex.lines]]
  in
  grid [] <| List.map cf hexs

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  let barXor = List.map2 xor sgram.bars mgram.bars
      lines op lns =
      [ Card.text [Color.text Color.primaryContrast] [text "Lines"]
      , Card.text [Color.text Color.primaryContrast] [ol [] (List.map2 (\line change -> li [] [if change then op <| text line else text line]) lns barXor)]
      ]
    in
  grid []
    [ cell [] <| List.singleton <| Card.view [Elevation.e8, Color.background Color.primary, Color.text Color.primaryContrast]
                (basicCard sgram ++ (lines <| del [] << List.singleton) sgram.lines)
    , cell [] <| List.singleton <| Card.view [Elevation.e8, Color.background Color.primaryDark, Color.text Color.primaryContrast] 
                (basicCard mgram ++ (lines <| em [] << List.singleton) sgram.lines)
    ]
view: Hexagram -> Html msg
view hex = Card.view [] <| basicCard hex
