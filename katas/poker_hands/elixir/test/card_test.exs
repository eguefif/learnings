defmodule CardTest do
  alias PokerHands.Card

  use ExUnit.Case,
    async: false,
    parameterize:
      for(
        {card1, card2, expect} <- [{"2C", "3H", :card2}, {"AD", "KS", :card1}, {"TH", "TC", :eq}],
        do: %{card1: card1, card2: card2, expect: expect}
      )

  test "should returns card struct from string" do
    %Card{ranking: ranking, suit: suit} = Card.new("AC")
    assert ranking == :as
    assert suit == :club
  end

  test "should compare cards", %{card1: c1, card2: c2, expect: expected} do
    assert Card.compare(c1, c2) == expected
  end
end
