defmodule NorthwindBook.Repo do
  use Ecto.Repo,
    otp_app: :northwind_book,
    adapter: Ecto.Adapters.SQLite3
end
