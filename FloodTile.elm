module FloodTile exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type Msg = Tap

type alias Model = {  
  targetIslandTile : Int,
  used: Bool
}

init : Int -> Model
init target = {targetIslandTile=target,used=False}

update : Msg -> Model -> Model
update msg model = case msg of
                        Tap -> {model | used = True}

view : Model -> Html Msg
view model = div [] [text (toString model) ]