module IslandTile exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type FloodState = Normal | Under | Sunk

type alias Model = {
  tid: Int,
  floodState : FloodState,
  text : String
}

init : Int -> Model
init tid = {tid=tid,floodState=Normal,text="Mystery Grove"}

type Msg = Flood | Shore

update : Msg -> Model -> Model
update msg model =
  case msg of
        Flood -> case model.floodState of
                      Normal -> {model | floodState = Under}
                      Under -> {model | floodState = Sunk}
                      Sunk -> model
        Shore -> case model.floodState of
                      Normal -> model
                      Under -> {model | floodState = Normal}
                      Sunk -> model

view : Model -> Html Msg
view model =
      div []
      [
        button [ onClick Flood ] [ text "*" ],
        text (toString model)
      ]