module IslandDeck exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import IslandTile

type alias Model = List (IslandTile.Model)

type Msg = Setup | Place Int IslandTile.Msg | FloodTile

init : Model
init = List.map IslandTile.init [1..24]

update : Msg -> Model -> Model
update msg model = case msg of
                        Setup -> init
                        Place tid msg -> List.map (\m -> if m.tid == tid then IslandTile.update msg m else m) model
                        FloodTile -> model

view : Model -> Html Msg
view model = div [] (List.map (\m -> App.map (Place m.tid) (IslandTile.view m)) model)