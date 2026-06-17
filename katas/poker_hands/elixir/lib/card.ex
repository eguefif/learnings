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
end
