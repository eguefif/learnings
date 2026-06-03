defmodule NorthwindMe.Repo do
  use Ecto.Repo,
    otp_app: :northwind_me,
    adapter: Ecto.Adapters.SQLite3
end
