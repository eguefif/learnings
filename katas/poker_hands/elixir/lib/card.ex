defmodule PokerHands.Card do
  defstruct [:ranking, :suit]

  @ranking %{
    "2" => :two,
    "3" => :three,
    "4" => :four,
    "5" => :five,
    "6" => :six,
    "7" => :seven,
    "8" => :eight,
    "9" => :nine,
    "T" => :ten,
    "J" => :jack,
    "Q" => :queen,
    "K" => :king,
    "A" => :as
  }
  @suit %{"D" => :diamond, "S" => :spades, "H" => :heart, "C" => :club}

  @values %{
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13,
    :as => 14
  }

  @doc """
    Create a new Card struct from a string.

    Returns %PokerHands.Card{}
  """
  def new(card) when is_bitstring(card) do
    %PokerHands.Card{ranking: card_to_ranking(card), suit: card_to_suit(card)}
  end

  defp card_to_ranking(card) do
    ranking_str = card |> String.graphemes() |> Enum.at(0)
    Map.get(@ranking, ranking_str)
  end

  defp card_to_suit(card) do
    suit_str = card |> String.graphemes() |> Enum.at(1)
    Map.get(@suit, suit_str)
  end

  def compare(card1, card2) when is_bitstring(card1) and is_bitstring(card2) do
    card1 = PokerHands.Card.new(card1)
    card2 = PokerHands.Card.new(card2)
    PokerHands.Card.compare(card1, card2)
  end

  def compare(
        %PokerHands.Card{ranking: r1, suit: _} = _,
        %PokerHands.Card{ranking: r2, suit: _} = _
      ) do
    v1 = Map.fetch!(@values, r1)
    v2 = Map.fetch!(@values, r2)

    cond do
      v1 == v2 -> :eq
      v1 > v2 -> :card1
      v1 < v2 -> :card2
    end
  end
end
