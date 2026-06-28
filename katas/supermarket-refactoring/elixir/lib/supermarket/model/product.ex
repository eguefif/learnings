defmodule Supermarket.Model.Product do
  defstruct [:name, :unit]

  alias Supermarket.Model.Product

  def new(name, unit), do: %__MODULE__{name: name, unit: unit}

  defimpl String.Chars, for: Supermarket.Model.Product do
    def to_string(%Product{} = product) do
      "Product #{product.name}(#{product.unit})"
    end
  end
end
