defmodule PokerHands.Combination do
  alias PokerHands.Card

  defstruct [:type, :high_card, :rest]

  def new(cards) when is_list(cards) do
    cards
    |> check_card_high()
  end

  defp check_card_high(cards) do
    [high_card | rest] =
      cards
      |> Enum.sort(fn card1, card2 ->
        case Card.compare(card1, card2) do
          :eq -> true
          :card1 -> true
          :card2 -> false
        end
      end)

    %PokerHands.Combination{type: :high, high_card: high_card, rest: rest}
  end
end
