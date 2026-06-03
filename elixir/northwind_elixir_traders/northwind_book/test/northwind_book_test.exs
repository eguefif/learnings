defmodule NorthwindBookTest do
  use ExUnit.Case
  doctest NorthwindBook

  test "greets the world" do
    assert NorthwindBook.hello() == :world
  end
end
