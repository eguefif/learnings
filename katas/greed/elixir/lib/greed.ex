defmodule Greed do
  @triples %{1 => 1000, 2 => 200, 3 => 300, 4 => 400, 5 => 500, 6 => 600}
  @multiplier %{1 => 0, 2 => 0, 3 => 1, 4 => 2, 5 => 4, 6 => 8}

  def score(dices) do
    {0, dices}
    |> check_straight
    |> check_pairs
    |> check_kinds
    |> check_singles
    |> elem(0)
  end

  defp check_straight({score, dices}) do
    case dices do
      [1, 2, 3, 4, 5, 6] -> {score + 1200, []}
      _ -> {score, dices}
    end
  end

  defp check_pairs({score, dices}) do
    frequencies =
      Enum.frequencies(dices)
      |> Map.values()

    case frequencies do
      [2, 2, 2] -> {score + 800, []}
      _ -> {score, dices}
    end
  end

  defp check_kinds({score, dices}) do
    dices
    |> Enum.frequencies()
    |> Enum.sort(fn {_, v1}, {_, v2} -> v1 >= v2 end)
    |> Enum.reduce({score, dices}, fn {k, v}, {score, dices} ->
      base_score = @triples[k]
      multiplier = @multiplier[v]
      new_score = base_score * multiplier

      if new_score > 0 do
        dices = Enum.reject(dices, fn dice -> dice == k end)
        {score + new_score, dices}
      else
        {score, dices}
      end
    end)
  end

  def check_singles({score, dices}) do
    freq = Enum.frequencies(dices)

    {score, dices} =
      if Map.get(freq, 1, nil) == 1 do
        {score + 100, dices |> Enum.reject(fn d -> d == 1 end)}
      else
        {score, dices}
      end

    {score, dices} =
      if Map.get(freq, 5, nil) == 1 do
        {score + 50, dices |> Enum.reject(fn d -> d == 5 end)}
      else
        {score, dices}
      end

    {score, dices}
  end
end
