defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe "TicTacToe.new/0" do
    test "next player is player 1" do
      game = TicTacToe.new()
      assert game.next_player == :player1
    end

    test "the board is empty" do
      game = TicTacToe.new()
      assert Enum.all?(game.board, &(elem(&1, 1) == :empty)) == true
    end
  end

  describe "TicTacToe.play/2" do
    test "players take turns" do
      game =
        TicTacToe.new()
        |> TicTacToe.play({1, 1})

      assert game.next_player == :player2
    end
  end
end
