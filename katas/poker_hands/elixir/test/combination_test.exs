defmodule CombinationTest do
  use ExUnit.Case
  alias PokerHands.Combination
  alias PokerHands.Card

  test "should detect high card" do
    # 2H 3D 5S 9C KD 
    cards =
      ["2H", "3D", "5S", "9C", "KD"]
      |> Enum.map(&Card.new/1)

    rest =
      ["2H", "3D", "5S", "9C"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :high_card
    assert Card.compare(combination.value, %Card{ranking: :king, suit: :diamond}) == :eq

    assert Enum.map(rest, &Enum.member?(combination.rest, &1)) |> Enum.all?(),
           "rests does not match"
  end

  test "should detect straight" do
    cards =
      ["2H", "3H", "4D", "5c", "6H"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :straight
    assert combination.value.ranking == Card.new("6H").ranking
    assert combination.value.suit == Card.new("6H").suit
    assert combination.rest == []
  end
end
