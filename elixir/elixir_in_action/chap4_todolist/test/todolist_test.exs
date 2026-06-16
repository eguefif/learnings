defmodule TodolistTest do
  use ExUnit.Case

  test "create empty todo list" do
    todo_list = TodoList.new()
    assert todo_list.next_id == 1
    assert todo_list.entries == %{}
  end

  test "create todo list from list" do
    entries = [
      %{date: ~D[2023-12-19], title: "Dentist"},
      %{date: ~D[2023-12-20], title: "Shopping"},
      %{date: ~D[2023-12-19], title: "Movies"}
    ]

    todo_list = TodoList.new(entries)
    assert todo_list.next_id == 4

    check =
      todo_list.entries
      |> Enum.map(fn {_k, v} ->
        Enum.find(entries, false, fn entry ->
          entry.date == v.date && entry.title == v.title
        end) != false
      end)

    assert Enum.all?(check) == true
  end

  test "add entries" do
    todo_list = TodoList.new()
    todo_list = TodoList.add_entry(todo_list, %{date: ~D[2026-06-20], title: "Dentist"})

    assert todo_list.next_id == 2
    assert map_size(todo_list.entries) == 1
    assert Map.fetch!(todo_list.entries, 1) == %{id: 1, date: ~D[2026-06-20], title: "Dentist"}
  end

  test "Delete entry by title" do
    entries = [
      %{date: ~D[2026-06-13], title: "Dentist"},
      %{date: ~D[2026-05-13], title: "Movies"}
    ]

    todo_list = TodoList.new(entries)
    todo_list = TodoList.delete_entry_by_title(todo_list, "Dentist")
    assert map_size(todo_list.entries) == 1
    assert Enum.find(todo_list.entries, fn {_k, v} -> v.title == "Dentist" end) == nil
  end
end
