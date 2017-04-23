module Hexagram exposing (Hexagram, hexagramList, renderReading)
import Html exposing (..)
import Material.Card as Card
import Material.Grid exposing (grid, cell, size, offset,  Device(..))
import Material.Color as Color
import Material.Options as Options exposing (css)
type alias Hexagram = 
  { number: Int
  , name: String
  , character: String
  , meaning: String
  , lines: List String
  , repr: List Bool
  , image: String
  , sequence: String 
  }

hexagramList : List Hexagram
hexagramList = [ { number = 1, name = "Test", character = "", meaning = "", lines = [""], repr = [True, True, True, True, True, True], image = "", sequence = "" } ]

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  grid []
    [ cell [size All 10, Color.background <| Color.primary, Options.center]
      [ h4 [] [text "Initial Hexagram"]
      ]
    , cell [size All 4, Color.background <| Color.accent, Options.center]
      [ 
        div [] [ h4 [] [text "Resultant Hexagram"]
               , p [] [text "Offset by 2"] ]
      ]
    ]
