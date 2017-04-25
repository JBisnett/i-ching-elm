module Hexagram exposing (Hexagram, renderReading, renderAll, toHtml)
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

toHtmlLines: Hexagram -> (List String -> List (Html msg) ) -> Html msg
toHtmlLines hex getLines = 
  Options.div [] <|
    (basicHtml hex ++ getLines hex.lines)

toHtml: Hexagram -> Html msg
toHtml hex = 
  let lines lns =
    [ h4 [] [text "Lines"]
    , ol [] (List.map (li [] << List.singleton << text) lns)
    ]
  in
     toHtmlLines hex lines

basicHtml: Hexagram -> List (Html msg)
basicHtml hex = 
    [ h1 [] [text hex.character]
    , h2 [] [text hex.name]
    , h3 [] [text hex.directName]
    , h4 [] [text "Judgement"]
    , p [] [text hex.judgement]
    , h4 [] [text "Image"]
    , p [] [text hex.image]
    ]

renderAll: List Hexagram -> Html msg
renderAll hexs = 
  let cf hex = cell [size All 4, Elevation.e2, Color.background Color.primary, Color.text Color.primaryContrast, Options.center] <| List.singleton <| toHtml hex
  in
  grid [Options.center] <| List.map cf hexs

renderReading: Hexagram -> Hexagram -> Html msg
renderReading sgram mgram = 
  let shared = [size All 5, Elevation.e2]
      barXor = List.map2 xor sgram.bars mgram.bars
      lines op lns =
      [ h4 [] [text "Lines"]
      , ol [] (List.map2 (\line change -> li [] [if change then op <| text line else text line]) lns barXor)
      ]
    in
  grid [Options.center]
    [ cell 
        (shared ++
        [ Color.background <| Color.primary
        , Color.text Color.primaryContrast
        , Options.center
        ]) 
        [ h1 [] [text "Initial"]
        , toHtmlLines sgram <| lines <| del [] << List.singleton
        ]
    , cell 
        (shared ++
        [ Color.background <| Color.primaryDark
        , Color.text Color.primaryContrast
        , Options.center
        ])
        [ h1 [] [text "Moving"]
        , toHtmlLines mgram <| lines <| em [] << List.singleton
        ]
    ]
