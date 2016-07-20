module FloodDeck exposing (Model, Msg, init, update, view, drawMsg)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import FloodTile

type alias Model = {
  floodTiles : List (FloodTile.Model)
}

type Msg = Place Int FloodTile.Msg | Draw

drawMsg : Msg
drawMsg = Draw

init : Model
init  = {floodTiles = List.map FloodTile.init [1..24]}

update : Msg -> Model -> Model
update msg model = case msg of
                        Place targetIslandTile msg -> {model | floodTiles = List.map (\m -> if m.targetIslandTile == targetIslandTile then FloodTile.update msg m else m) model.floodTiles}
                        Draw -> {model | floodTiles = List.drop 1 model.floodTiles}

view : Model -> Html Msg
view model = div [] ((List.map (\m -> App.map (Place m.targetIslandTile) (FloodTile.view m)) model.floodTiles))