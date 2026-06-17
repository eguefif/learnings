defmodule CardTest do
  use ExUnit.Case
  alias PokerHands.Card

  test "should returns card struct from string" do
    %Card{ranking: ranking, suit: suit} = Card.new("AC")
    assert ranking == :as
    assert suit == :club
  end
end
