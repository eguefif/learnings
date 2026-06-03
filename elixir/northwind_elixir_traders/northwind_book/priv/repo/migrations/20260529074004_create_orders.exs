defmodule NorthwindBook.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:customer_id, references(:customers))
      add(:employee_id, references(:employees))
      add(:shipper_id, references(:shippers))
      add(:date, :utc_datetime)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:orders, [:customer_id, :employee_id, :shipper_id, :date]))
  end
end
