import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)
import IslandDeck
import FloodDeck

type alias Model =
  {
    islandDeck : IslandDeck.Model,
    floodDeck: FloodDeck.Model
  }
  
isd : IslandDeck.Model
isd = IslandDeck.init  

init : Int -> Model
init count = {
    islandDeck = isd,
    floodDeck = FloodDeck.init
  }

main =
  App.beginnerProgram { model = init 10, view = view, update = update }

type Msg =  Deck IslandDeck.Msg | DeckFlood FloodDeck.Msg | Draw

update msg model =
  case msg of
    Deck msg ->
      {model | islandDeck = IslandDeck.update msg model.islandDeck}
    DeckFlood msg ->
      {model | floodDeck = FloodDeck.update msg model.floodDeck}
    Draw -> let tile = List.head model.floodDeck.floodTiles {model | floodDeck = FloodDeck.update FloodDeck.drawMsg model.floodDeck }

view model =
  div []
    [div [] [ text (toString model) ],
    (button [ onClick (Draw) ] [ text "Draw" ])
    , App.map DeckFlood (FloodDeck.view (model.floodDeck))
    , App.map Deck (IslandDeck.view (model.islandDeck))
    ]