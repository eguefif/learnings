defmodule GreedTest do
  use ExUnit.Case
  doctest Greed

  test "score 0" do
    assert Greed.score([2, 2, 3, 4, 4, 6]) == 0
  end

  test "straight" do
    assert Greed.score([1, 2, 3, 4, 5, 6]) == 1200
  end

  test "pairs" do
    assert Greed.score([1, 1, 2, 2, 3, 3]) == 800
  end

  test "six of a kinds" do
    assert Greed.score([2, 2, 2, 2, 2, 2]) == 200 * 8
  end

  test "five of a kinds" do
    assert Greed.score([2, 2, 2, 2, 2]) == 200 * 4
  end

  test "four of a kinds" do
    assert Greed.score([2, 2, 2, 2]) == 200 * 2
  end

  test "triple of a kinds of 2" do
    assert Greed.score([2, 2, 2]) == 200
  end

  test "triple of a kinds of 1" do
    assert Greed.score([1, 1, 1]) == 1000
  end

  test "triple of a kinds of 1 and triple of 5" do
    assert Greed.score([1, 1, 1, 5, 5, 5]) == 1500
  end

  test "single of 1" do
    assert Greed.score([1, 2, 3, 6, 2, 6]) == 100
  end

  test "single of 5" do
    assert Greed.score([5, 2, 3, 6, 2, 6]) == 50
  end

  test "Four of a kind of 2 and one hundred and one fifty" do
    assert Greed.score([2, 2, 2, 2, 1, 5]) == 550
  end

  test "Four of a kind of 2 and one hundred" do
    assert Greed.score([2, 2, 2, 2, 1, 4]) == 500
  end

  test "Four of a kind of 2 and one fifty" do
    assert Greed.score([2, 2, 2, 2, 5]) == 450
  end
end
