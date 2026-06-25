defmodule PokerHands.Combination do
  alias PokerHands.Card
  alias PokerHands.Combination

  # TODO: add tests to cover comparison

  defstruct [:type, :value, :rest, :cards]

  @combination_ranking %{
    :high_card => 0,
    :pair => 1,
    :double_pair => 2,
    :three_of_a_kind => 3,
    :straight => 5,
    :flush => 6,
    :full_house => 7,
    :four_of_a_kind => 8,
    :straight_flush => 9
  }

  @doc """
    Compare two combinations and return :black or :white
  """

  def compare(%Combination{} = black, %Combination{} = white) do
    value_black = combination_to_ranking_value(black)
    value_white = combination_to_ranking_value(white)

    cond do
      value_black > value_white ->
        :black

      value_black < value_white ->
        :white

      value_black == value_white ->
        case PokerHands.Card.compare(black.value, white.value) do
          :card1 -> :black
          :card2 -> :white
          :eq -> compare_rest(black.rest, white.rest)
        end
    end
  end

  defp compare_rest(black_cards, white_cards) when length(black_cards) == 1 do
    [black_card] = black_cards
    [white_card] = white_cards

    case PokerHands.Card.compare_suit(black_card, white_card) do
      :card1 -> :black
      :card2 -> :white
    end
  end

  defp compare_rest(black_cards, white_cards) do
    [black_card | black_tail] = black_cards
    [white_card | white_tail] = white_cards

    case PokerHands.Card.compare(black_card, white_card) do
      :eq -> compare_rest(black_tail, white_tail)
      :card1 -> :black
      :card2 -> :white
    end
  end

  defp combination_to_ranking_value(%Combination{type: type} = _) do
    Map.get(@combination_ranking, type)
  end

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
    |> check_three_of_a_kind()
    |> check_pairs()
    |> check_full_house()
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
      |> then(fn keys ->
        ranking = Enum.at(keys, 0)
        card = cards |> Enum.find(fn card -> card.ranking == ranking end)
        if Enum.count(keys) > 0, do: {true, card}, else: false
      end)

    case is_four_of_a_kind do
      {true, value} ->
        rest = cards |> Enum.reject(fn card -> card.ranking == value.ranking end)
        %Combination{combination | type: [:four_of_a_kind], value: value, rest: rest}

      _ ->
        combination
    end
  end

  defp check_four_of_a_kind(%Combination{} = combination) do
    combination
  end

  defp check_three_of_a_kind(%Combination{type: type} = combination)
       when type != [] do
    combination
  end

  defp check_three_of_a_kind(%Combination{rest: rest, cards: cards} = combination) do
    is_three_of_a_kind =
      rest
      |> Enum.map(& &1.ranking)
      |> Enum.frequencies()
      |> Map.filter(fn {_, v} -> v == 3 end)
      |> Map.keys()
      |> then(fn keys ->
        ranking = Enum.at(keys, 0)
        value = Enum.find(cards, fn card -> card.ranking == ranking end)
        if length(keys) == 1, do: {true, value}
      end)

    case is_three_of_a_kind do
      {true, value} ->
        rest = cards |> Enum.reject(fn card -> card.ranking == value.ranking end)
        %Combination{combination | type: [:three_of_a_kind], value: value, rest: rest}

      _ ->
        combination
    end
  end

  defp check_pairs(%Combination{rest: rest} = combination) when rest < 2 do
    combination
  end

  defp check_pairs(%Combination{type: type, rest: rest, cards: cards} = combination) do
    pairs =
      rest
      |> Enum.map(& &1.ranking)
      |> Enum.frequencies()
      |> Map.filter(fn {_, v} -> v == 2 end)
      |> Map.keys()
      |> Enum.map(fn key -> cards |> Enum.find(fn card -> card.ranking == key end) end)

    case pairs do
      [pair1, pair2] ->
        value = if Card.to_value(pair1) > Card.to_value(pair2), do: pair1, else: pair2

        rest =
          cards
          |> Enum.reject(fn card ->
            card.ranking == pair2.ranking or card.ranking == pair1.ranking
          end)

        %Combination{combination | type: [:double_pair | type], rest: rest, value: value}

      [pair] ->
        rest =
          cards
          |> Enum.reject(fn card -> Card.compare(card, pair) end)

        %Combination{combination | type: [:pair | type], rest: rest, value: pair}

      _ ->
        combination
    end
  end

  defp check_full_house(%Combination{type: type, cards: cards} = combination)
       when length(type) == 2 do
    if :pair in type && :three_of_a_kind in type do
      value =
        cards
        |> Enum.map(& &1.ranking)
        |> Enum.frequencies()
        |> Map.filter(&(elem(&1, 1) == 3))
        |> Map.keys()
        |> Enum.map(fn key -> cards |> Enum.find(fn card -> card.ranking == key end) end)
        |> Enum.at(0)

      %Combination{combination | type: [:full_house], value: value, rest: []}
    else
      combination
    end
  end

  defp check_full_house(combination) do
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
