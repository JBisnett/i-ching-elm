module Hexagram exposing (Hexagram, hexagramList, renderReading, toHtml)
import Html exposing (..)
import Material.Card as Card
import Material.Grid exposing (grid, cell, size, offset,  Device(..))
import Material.Color as Color
import Material.Options as Options exposing (css)
import Material.Elevation as Elevation
import HtmlParser as Parser
import RawHexagrams exposing (rawHexagrams)
type alias Hexagram = 
  { number: Int
  , name: String
  , descriptor: String
  , directName: String
  , character: String
  , image: String
  , judgement: String
  , lines: List String
  , repr: List Bool
  , picture: String
  }

parsedHexagrams : List Parser.Node
parsedHexagrams = Parser.parse rawHexagrams

hexagramList : List Hexagram
hexagramList = 
  [ { number = 1
    , name = "Force"
    , descriptor = "The Creative"
    , directName = "qián"
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
    , name = "Field"
    , descriptor = "The Receptive"
    , directName = "kūn"
    , character = "䷁"
    , judgement = "The Receptive brings about sublime success, furthering through the perseverance of a mare. If the superior man undertakes something and tries to lead, he goes astray; But if he follows, he finds guidance. It is favorable to find friends in the west and south, to forego friends in the east and north. Quiet perseverance brings good fortune."
    , image = "The earth's condition is receptive devotion. Thus the superior man who has breadth of character carries the outer world."
    , lines = 
      [ "When there is hoarfrost underfoot, solid ice is not far off."
      , "Straight, square, great. Without purpose, yet nothing remains unfurthered."
      , "Hidden lines. One is able to remain persevering. If by chance you are in the service of a king, seek not works, but bring to completion."
      , "A tied-up sack. No blame, no praise."
      , "A yellow lower garment brings supreme good fortune."
      , "Dragons fight in the meadow. Their blood is black and yellow."
      ]
    , repr = [False, False, False, False, False, False]
    , picture = ""
    }
  , { number = 3
    , name = "Sprouting"
    , descriptor = "Difficulty at the Beginning"
    , directName = ""
    , character = "䷁"
    , judgement = "The Receptive brings about sublime success, furthering through the perseverance of a mare. If the superior man undertakes something and tries to lead, he goes astray; But if he follows, he finds guidance. It is favorable to find friends in the west and south, to forego friends in the east and north. Quiet perseverance brings good fortune."
    , image = "The earth's condition is receptive devotion. Thus the superior man who has breadth of character carries the outer world."
    , lines = 
      [ "When there is hoarfrost underfoot, solid ice is not far off."
      , "Straight, square, great. Without purpose, yet nothing remains unfurthered."
      , "Hidden lines. One is able to remain persevering. If by chance you are in the service of a king, seek not works, but bring to completion."
      , "A tied-up sack. No blame, no praise."
      , "A yellow lower garment brings supreme good fortune."
      , "Dragons fight in the meadow. Their blood is black and yellow."
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
