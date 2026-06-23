defmodule PokerHands.Combination do
  alias PokerHands.Card
  alias PokerHands.Combination

  defstruct [:type, :value, :rest, :cards]

  # TODO:
  # - [ ] Refactor value, should be the ranking not a card
  #   - [ ] check flush
  #   - [ ] check straight
  # - [ ] check triple
  # - [ ] check one pair
  # - [ ] check two pair
  # - [ ] check full house
  # - [x] check straight
  # - [x] check four of a kind
  # - [x] check straight flush
  # - [x] Think of a way to place straight_flush, full_house and double pair after pair
  # flush and straight. These function will only check if there is the right combination

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
    |> check_straight_flush()
    |> check_four_of_a_kind()
    |> check_three_of_a_kind(cards)
    |> check_pairs(cards)
    |> check_full_house(cards)
    |> check_card_high()
    |> combine()
  end

  defp check_straight(%Combination{cards: cards} = combination) do
    is_straight =
      cards
      |> sort_hands
      |> Enum.map(&Card.to_value(&1))
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [v1, v2] -> v1 + 1 == v2 end)
      |> Enum.all?()

    if is_straight do
      %Combination{
        combination
        | type: [:straight | combination.type],
          value: get_high_card(cards),
          rest: []
      }
    else
      combination
    end
  end

  defp check_flush(%Combination{type: type, cards: cards} = combination) do
    is_flush =
      cards
      |> Enum.map(&Card.to_suit/1)
      |> Enum.frequencies()
      |> Map.values()
      |> then(&(&1 == [5]))

    if is_flush do
      %Combination{combination | type: [:flush | type], rest: [], value: get_high_card(cards)}
    else
      combination
    end
  end

  defp check_straight_flush(%Combination{type: type} = combination) do
    if :straight in type && :flush in type do
      %Combination{combination | type: [:straight_flush]}
    else
      combination
    end
  end

  defp check_four_of_a_kind(%Combination{type: type, cards: cards} = combination)
       when type == [] do
    is_four_of_a_kind =
      cards
      |> Enum.map(& &1.ranking)
      |> Enum.frequencies()
      |> Map.filter(fn {_, v} -> v == 4 end)
      |> Map.keys()
      |> then(fn cards ->
        if Enum.count(cards) > 0, do: {true, Enum.at(cards, 0)}, else: false
      end)

    case is_four_of_a_kind do
      {true, value} ->
        value_card = cards |> Enum.find(fn card -> card.ranking == value end)
        rest = cards |> Enum.reject(fn card -> card.ranking == value end)
        %Combination{combination | type: [:four_of_a_kind], value: value_card, rest: rest}

      _ ->
        combination
    end
  end

  defp check_four_of_a_kind(%Combination{} = combination) do
    combination
  end

  defp check_card_high(%Combination{type: type, rest: rest} = combination)
       when type != [] or rest == [],
       do: combination

  defp check_card_high(%Combination{rest: rest, cards: cards} = combination) do
    [value | rest] =
      rest
      |> sort_hands(:desc)

    rest = rest |> Enum.reverse()

    %Combination{type: [:high_card | combination.type], value: value, rest: rest, cards: cards}
  end

  defp combine(%Combination{type: type} = combination) do
    [hd | _] = type
    %Combination{combination | type: hd}
  end

  defp check_pairs(combination, _cards) do
    combination
  end

  defp check_three_of_a_kind(combination, _cards) do
    combination
  end

  defp check_full_house(combination, _cards) do
    combination
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
