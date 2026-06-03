defmodule NorthwindBook.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias NorthwindBook.{Category, Validations, Supplier}

  @name_mxlen 50

  schema "products" do
    field(:name, :string)
    field(:unit, :string)
    field(:price, :float)
    field(:category_id, :integer)
    belongs_to(:supplier, Supplier)
    belongs_to(:category, Category, define_field: false)

    timestamps(type: :utc_datetime)
  end

  def changeset(data, params \\ %{}) do
    permitted = [:id, :name, :unit, :price, :category_id, :supplier_id]
    required = permitted |> List.delete(:id)

    data
    |> cast(params, permitted)
    |> validate_required(required)
    |> validate_length(:name, max: @name_mxlen)
    |> foreign_key_constraint(:category_id, name: "products_category_id_fkey")
    |> Validations.validate_foreign_key_id(Category, :category_id)
    |> Validations.validate_foreign_key_id(Supplier, :supplier_id)
    |> unique_constraint([:name])
    |> unique_constraint([:id])
  end
end
