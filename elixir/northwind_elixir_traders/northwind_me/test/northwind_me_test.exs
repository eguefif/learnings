defmodule NorthwindMeTest do
  use ExUnit.Case
  doctest NorthwindMe

  test "greets the world" do
    assert NorthwindMe.hello() == :world
  end
end
