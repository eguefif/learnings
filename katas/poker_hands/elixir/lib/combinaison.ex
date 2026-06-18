defmodule PokerHands.Combination do
  alias PokerHands.Card
  alias PokerHands.Combination

  defstruct [:type, :value, :rest, :cards]

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
    Create a new combination from a list of Card.

    It checks one by one from the longest to the shortest combination.

    Returns %Combination{type, value, rest}

      Type: one the known poker combination: high card, pair, two pairs, 
          three of a kind, straight, full house, four of a kind, straight flush

      high card is the top card of the combination. Example:
        For the hand 4h, 4s, 4h => the value is 4
  """
  def new(cards) when is_list(cards) do
    %Combination{type: [], value: nil, rest: cards, cards: cards}
    |> check_straight()
    |> check_flush()
    |> check_four_of_a_kind(cards)
    |> check_full_house(cards)
    |> check_three_of_a_kind(cards)
    |> check_pairs(cards)
    |> check_card_high()
    |> combine()
  end

  defp combine(%Combination{type: type, value: _value, rest: _rest, cards: _} = combination) do
    cond do
      [:straight] == type -> %Combination{combination | type: :straight}
      [:high_card] == type -> %Combination{combination | type: :high_card}
      true -> combination
    end
  end

  defp check_card_high(%Combination{type: _, value: _, rest: rest, cards: _} = combination)
       when rest == [],
       do: combination

  defp check_card_high(%Combination{type: _, value: _, rest: rest, cards: cards} = combination)
       when rest != [] do
    [value | rest] =
      rest
      |> sort_hands(:desc)

    rest = rest |> Enum.reverse()

    %Combination{type: [:high_card | combination.type], value: value, rest: rest, cards: cards}
  end

  defp check_pairs(combination, _cards) do
    combination
  end

  defp check_three_of_a_kind(combination, _cards) do
    combination
  end

  defp check_straight(%Combination{type: _, value: _, rest: _, cards: cards} = combination) do
    is_straight =
      cards
      |> sort_hands
      |> Enum.map(&Card.to_value(&1))
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [v1, v2] -> v1 + 1 == v2 end)
      |> Enum.all?()

    if is_straight do
      %Combination{type: [:straight | combination.type], value: get_high_card(cards), rest: []}
    else
      combination
    end
  end

  defp check_full_house(combination, _cards) do
    combination
  end

  defp check_four_of_a_kind(combination, _cards) do
    combination
  end

  defp check_flush(%Combination{type: _, value: v, rest: rest, cards: cards} = _combination) do
    _combination
  end

  defp sort_hands(cards, order \\ :asc) do
    cards
    |> Enum.sort(fn card1, card2 ->
      case Card.compare(card1, card2) do
        :eq -> true
        :card1 -> if order == :asc, do: false, else: true
        :card2 -> if order == :asc, do: true, else: false
      end
    end)
  end

  defp get_high_card(cards) when is_list(cards) do
    [hd | _] =
      cards
      |> sort_hands(:desc)

    hd
  end
end
