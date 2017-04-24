module Hexagram exposing (Hexagram, hexagramList, renderReading, toHtml)
import Html exposing (..)
import Material.Card as Card
import Material.Grid exposing (grid, cell, size, offset,  Device(..))
import Material.Color as Color
import Material.Options as Options exposing (css)
import Material.Elevation as Elevation
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
      [ "Hidden dragon. Do not act."
      , "Dragon appearing in the field. It furthers one to see the great man."
      , "All day long the superior man is creatively active. At nightfall his mind is still beset with cares. Danger. No blame."
      , "Wavering flight over the depths. No blame."
      , "Flying dragon in the heavens. It furthers one to see the great man."
      , "Arrogant dragon will have cause to repent."
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
      [ "Hidden dragon. Do not act."
      , "Dragon appearing in the field. It furthers one to see the great man."
      , "All day long the superior man is creatively active. At nightfall his mind is still beset with cares. Danger. No blame."
      , "Wavering flight over the depths. No blame."
      , "Flying dragon in the heavens. It furthers one to see the great man."
      , "Arrogant dragon will have cause to repent."
      ]
    , repr = [False, False, False, False, False, False]
    , picture = ""
    }
  ]

toHtml: Hexagram -> Html msg
toHtml hex = 
  Options.div [] <|
    [ h1 [] [text hex.character]
    , h2 [] [text hex.directName]
    , h3 [] [text hex.name]
    , h4 [] [text "Judgement"]
    , p [] [text hex.judgement]
    , h4 [] [text "Image"]
    , p [] [text hex.image]
    , h4 [] [text "Lines"]
    , ol [] <| List.map (li [] << List.singleton << text) hex.lines
    ]

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  let shared = [size All 5, Elevation.e2] in
  grid [Options.center]
    [ cell 
        (shared ++
        [ Color.background <| Color.primary
        , Color.text Color.primaryContrast
        , Options.center
        ]) 
        [ h1 [] [text "Initial"]
        , toHtml sgram
        ]
    , cell 
        (shared ++
        [ Color.background <| Color.primaryDark
        , Color.text Color.primaryContrast
        , Options.center
        ])
        [ h1 [] [text "Moving"]
        , toHtml mgram 
        ]
    ]
