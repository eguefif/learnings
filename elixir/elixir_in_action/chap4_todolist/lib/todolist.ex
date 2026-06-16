defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  # TODO:
  #   - [x] Update entry
  #   - [x] Delete entry
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

  def delete_entry_by_title(%TodoList{next_id: id, entries: entries} = _, title)
      when is_bitstring(title) do
    entries = Map.reject(entries, fn {_k, v} -> v.title == title end)
    %TodoList{next_id: id, entries: entries}
  end

  def update_by_id(%TodoList{next_id: next_id, entries: entries} = todo_list, id, new_todo)
      when is_integer(id) do
    case Map.get(entries, id) do
      nil ->
        TodoList.add_entry(todo_list, new_todo)

      _ ->
        %{
          next_id: next_id,
          entries: Map.update(entries, id, nil, fn v -> Map.merge(v, new_todo) end)
        }
    end
  end

  def get_by_id(%TodoList{next_id: _, entries: entries} = _, id) when is_integer(id) do
    Map.get(entries, id)
  end
end
