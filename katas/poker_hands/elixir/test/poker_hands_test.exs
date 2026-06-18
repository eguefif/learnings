defmodule PokerHandsTest do
  use ExUnit.Case
  doctest PokerHands

  test "" do
    assert PokerHands.hello() == :world
  end
end
