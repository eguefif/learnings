defmodule ComprehensionsTest do
  use ExUnit.Case
  doctest Comprehensions

  test "greets the world" do
    assert Comprehensions.hello() == :world
  end
end
