defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  # TODO:
  #   - [ ] Update entry
  #   - [ ] Delete entry
  #   - [ ] Get all entries
  #   - [ ] Get one entry from id
  #   - [ ] Create todo list from csv file
  def new(entries \\ []) do
    entries
    |> Enum.reduce(
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(%TodoList{next_id: id, entries: entries}, entry) when is_map(entry) do
    entry = Map.put(entry, :id, id)
    entries = Map.put(entries, id, entry)
    %TodoList{next_id: id + 1, entries: entries}
  end

  def delete_entry_by_title(%TodoList{next_id: id, entries: entries}, title)
      when is_bitstring(title) do
    entries = Map.reject(entries, fn {_k, v} -> v.title == title end)
    %TodoList{next_id: id, entries: entries}
  end
end
