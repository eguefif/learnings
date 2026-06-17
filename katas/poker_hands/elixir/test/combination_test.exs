defmodule CombinationTest do
  use ExUnit.Case
  alias PokerHands.Combination
  alias PokerHands.Card

  test "greets the world" do
    # 2H 3D 5S 9C KD 
    cards =
      ["2H", "3D", "5S", "9C", "KD"]
      |> Enum.map(&Card.new/1)

    rest =
      ["2H", "3D", "5S", "9C"]
      |> Enum.map(&Card.new/1)

    combination = Combination.new(cards)
    assert combination.type == :high
    assert Card.compare(combination.value, %Card{ranking: :king, suit: :diamond}) == :eq

    assert Enum.map(rest, &Enum.member?(combination.rest, &1)) |> Enum.all?(),
           "rests does not match"
  end
end
