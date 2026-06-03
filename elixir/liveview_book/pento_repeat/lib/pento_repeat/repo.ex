defmodule PentoRepeat.Repo do
  use Ecto.Repo,
    otp_app: :pento_repeat,
    adapter: Ecto.Adapters.Postgres
end
