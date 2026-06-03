defmodule NorthwindBook.Supplier do
  use Ecto.Schema
  import Ecto.Changeset
  alias NorthwindBook.{Product, PhoneNumbers, Validations}

  @name_mxlen 50

  schema "suppliers" do
    field(:name, :string)
    field(:contact_name, :string)
    field(:address, :string)
    field(:city, :string)
    field(:postal_code, :string)
    field(:country, :string)
    field(:phone, :string)
    has_many(:products, Product)

    timestamps(type: :utc_datetime)
  end

  def changeset(data, params \\ %{}) do
    permitted = [:id, :name, :contact_name, :address, :city, :postal_code, :country, :phone]
    required = permitted |> List.delete(:id)

    data
    |> cast(params, permitted)
    |> validate_required(required)
    |> validate_length(:name, max: @name_mxlen)
    |> PhoneNumbers.validate_phone(:phone, :country)
    |> Validations.validate_country(:country)
    |> unique_constraint([:name])
    |> unique_constraint([:id])
  end
end
