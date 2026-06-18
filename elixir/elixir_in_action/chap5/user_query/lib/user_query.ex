defmodule Mix.Tasks.UserQuery do
  use Mix.Task

  def run(_) do
    IO.puts("Starting query")
    start_time = DateTime.utc_now()

    [1, 2, 3, 4, 5]
    |> Enum.map(&query_user/1)
    |> Enum.map(fn _ -> collect_result() end)
    |> IO.inspect()

    diff = DateTime.diff(DateTime.utc_now(), start_time, :millisecond)
    IO.puts("Duration: #{diff}")
  end

  def collect_result do
    receive do
      {:ok, id, result} -> {id, result}
      {:error, id, message} -> {:error, "Error => id: #{id} with message: #{message}"}
    end
  end

  def query_user(id) do
    pid = self()

    spawn(fn ->
      Process.sleep(:rand.uniform(400) + 100)
      send(pid, {:ok, id, "user_#{id}"})
    end)
  end
end
