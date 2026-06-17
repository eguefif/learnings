defmodule PokerHands.Combination do
  alias PokerHands.Card
  alias PokerHands.Combination

  defstruct [:type, :value, :rest]

  # TODO:
  # - [ ] check one pair
  # - [ ] check two pair
  # - [ ] check triple
  # - [ ] check straight
  # - [ ] check full house
  # - [ ] check four of a kind
  # - [ ] check straight flush

  # Place the checks from the weakest to the strongest.
  # Next functions will take the combination and the whole cards

  # Refactor, the remaining are used in case we have the same combination
  # with the same high card.

  @doc """
    Create a new combination.

    It checks one by one from the weakest to the strongest combination.

    Returns %Combination{type, value, rest}

      Type is one the known poker combination: high card, pair, two pairs, 
          three of a kind, straight, full house, four of a kind, straight flush

      high card is the top card of the combination. Example:
        For the hand 4h, 4s, 4h => the value is 4
  """
  def new(cards) when is_list(cards) do
    cards
    |> check_card_high()
    |> check_pairs(cards)
    |> check_three_of_a_kind(cards)
    |> check_straight(cards)
    |> check_full_house(cards)
    |> check_four_of_a_kind(cards)
    |> check_straight_flush(cards)
  end

  defp check_card_high(cards) do
    [value | rest] =
      cards
      # Sort in descending order: the strongest first
      |> Enum.sort(fn card1, card2 ->
        case Card.compare(card1, card2) do
          :eq -> true
          :card1 -> true
          :card2 -> false
        end
      end)

    rest = rest |> Enum.reverse()

    %Combination{type: :high, value: value, rest: rest}
  end

  defp check_pairs(combination, _cards) do
    combination
  end

  defp check_three_of_a_kind(combination, _cards) do
    combination
  end

  defp check_straight(combination, _cards) do
    combination
  end

  defp check_full_house(combination, _cards) do
    combination
  end

  defp check_four_of_a_kind(combination, _cards) do
    combination
  end

  defp check_straight_flush(combination, _cards) do
    combination
  end
end
