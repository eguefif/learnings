defmodule TodoList.CSVImporter do
  def import_csv(filename) when is_bitstring(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [date, title] =
        String.split(line, ",")
        |> Enum.map(&String.trim(&1))

      date = date |> Date.from_iso8601!()
      %{date: date, title: title}
    end)
  end
end
