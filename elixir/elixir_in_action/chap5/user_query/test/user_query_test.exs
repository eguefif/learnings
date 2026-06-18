defmodule UserQueryTest do
  use ExUnit.Case
  doctest UserQuery

  test "greets the world" do
    assert UserQuery.hello() == :world
  end
end
