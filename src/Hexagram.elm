module Hexagram exposing (Hexagram, hexagramList, renderReading)
import Html exposing (..)
import Material.Card as Card
import Material.Grid exposing (grid, cell, size, offset,  Device(..))
import Material.Color as Color
import Material.Options as Options exposing (css)
type alias Hexagram = 
  { number: Int
  , name: String
  , directName: String
  , character: String
  , image: String
  , judgement: String
  , lines: List String
  , repr: List Bool
  , picture: String
  }

hexagramList : List Hexagram
hexagramList = 
  [ { number = 1
    , name = "The Creative"
    , directName = "Ch'ien"
    , character = "䷀"
    , judgement = "The Creative works sublime success, Furthering through perseverance."
    , image = "The movement of heaven is full of power. Thus the superior man makes himself strong and untiring."
    , lines = 
      [ "Nine at the beginning means: Hidden dragon. Do not act."
      , "Nine in the second place means: Dragon appearing in the field. It furthers one to see the great man."
      , "Nine in the third place means: All day long the superior man is creatively active. At nightfall his mind is still beset with cares. Danger. No blame."
      , "Nine in the fourth place means: Wavering flight over the depths. No blame."
      , "Nine in the fifth place means: Flying dragon in the heavens. It furthers one to see the great man."
      , "Nine at the top means: Arrogant dragon will have cause to repent."
      ]
    , repr = [True, True, True, True, True, True]
    , picture = ""
    }
  , { number = 2
    , name = "The Receptive"
    , directName = "K'un"
    , character = "䷁"
    , judgement = "The Creative works sublime success, Furthering through perseverance."
    , image = "The movement of heaven is full of power. Thus the superior man makes himself strong and untiring."
    , lines = 
      [ "Nine at the beginning means: Hidden dragon. Do not act."
      , "Nine in the second place means: Dragon appearing in the field. It furthers one to see the great man."
      , "Nine in the third place means: All day long the superior man is creatively active. At nightfall his mind is still beset with cares. Danger. No blame."
      , "Nine in the fourth place means: Wavering flight over the depths. No blame."
      , "Nine in the fifth place means: Flying dragon in the heavens. It furthers one to see the great man."
      , "Nine at the top means: Arrogant dragon will have cause to repent."
      ]
    , repr = [False, False, False, False, False, False]
    , picture = ""
    }
  ]

toHtml: Hexagram -> Html msg
toHtml hex = 
  div [] 
    [ h1 [] [text hex.character]
    , h2 [] [text hex.directName]
    , h3 [] [text hex.name]
    , h4 [] [text "Judgement"]
    , p [] [text hex.judgement]
    , h4 [] [text "Image"]
    , p [] [text hex.image]
    , h4 [] [text "Lines"]
    ]

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  grid [Options.center]
  [ cell [size All 5, Color.background <| Color.primary, Color.text Color.primaryContrast, Options.center]
  [ toHtml sgram
  ]
  , cell [size All 5, Color.background <| Color.primaryDark, Color.text Color.primaryContrast, Options.center]
  [ toHtml mgram 
  ]
  ]
