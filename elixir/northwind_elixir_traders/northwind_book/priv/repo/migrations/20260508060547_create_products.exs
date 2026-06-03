defmodule NorthwindBook.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string, null: false)
      add(:unit, :string)
      add(:price, :numeric, scale: 7, precision: 2, default: 0.0)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:products, [:name]))
  end
end
