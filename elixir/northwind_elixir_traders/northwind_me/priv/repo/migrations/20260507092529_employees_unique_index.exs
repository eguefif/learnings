defmodule NorthwindMe.Repo.Migrations.EmployeesUniqueIndex do
  use Ecto.Migration

  def change do
    create(unique_index(:employees, [:first_name, :last_name, :birth_date]))
  end
end
