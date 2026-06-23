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

  test "should detect flush" do
    cards =
      ["2H", "3H", "4H", "5H", "TH"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :flush
    assert combination.value.ranking == Card.new("TH").ranking
    assert combination.value.suit == Card.new("TH").suit
    assert combination.rest == []
  end

  test "should detect straight flush" do
    cards =
      ["6H", "7H", "8H", "9H", "TH"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :straight_flush
    assert combination.value.ranking == Card.new("TH").ranking
    assert combination.value.suit == Card.new("TH").suit
    assert combination.rest == []
  end

  test "should detect four of a kind" do
    cards =
      ["5H", "5S", "5C", "5D", "TH"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :four_of_a_kind
    assert combination.value == Card.new("5H")
    assert combination.rest == [Card.new("TH")]
  end

  test "should detect three of a kind" do
    cards =
      ["5H", "5S", "5C", "9D", "TH"]
      |> Enum.map(&Card.new/1)

    combination = cards |> Combination.new()
    assert combination.type == :three_of_a_kind
    assert combination.value == Card.new("5H")

    assert combination.rest
           |> Enum.map(fn card ->
             Enum.member?([Card.new("9D"), Card.new("TH")], card)
           end)
           |> Enum.all?() == true
  end
end
