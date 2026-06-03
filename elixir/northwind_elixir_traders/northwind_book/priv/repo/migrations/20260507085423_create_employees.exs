defmodule NorthwindBook.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table("employees") do
      add(:first_name, :string, null: false)
      add(:last_name, :string, null: false)
      add(:birth_date, :date, null: false)
      add(:photo, :string)
      add(:notes, :string)

      timestamps(type: :utc_datetime)
    end
  end
end
