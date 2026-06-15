defmodule TicTacToe do
  defstruct next_player: :player1,
            board: %{
              {1, 1} => :empty,
              {1, 2} => :empty,
              {1, 3} => :empty,
              {2, 1} => :empty,
              {2, 2} => :empty,
              {2, 3} => :empty,
              {3, 1} => :empty,
              {3, 2} => :empty,
              {3, 3} => :empty
            }

  def new do
    %TicTacToe{}
  end

  def play(%TicTacToe{next_player: player, board: board} = _, position) do
    {next_player, board} = play_turn(player, board, position)
    %TicTacToe{next_player: next_player, board: board}
  end

  defp play_turn(player, board, position) when is_atom(player) do
    board = Map.update!(board, position, fn _ -> player end)
    next_player = if player == :player1, do: :player2, else: :player1
    {next_player, board}
  end
end
