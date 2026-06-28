defmodule Supermarket.Model.Catalog do
  defstruct [:products, :prices]

  def new, do: %__MODULE__{products: %{}, prices: %{}}

  defimpl Supermarket.Model.SupermarketCatalog, for: Supermarket.Model.Catalog do
    def add_product(%Supermarket.Model.Catalog{} = catalog, product, price) do
      catalog
      |> Map.update!(:products, &Map.put(&1, product.name, product))
      |> Map.update!(:prices, &Map.put(&1, product.name, price))
    end

    def get_unit_price(%Supermarket.Model.Catalog{} = catalog, product) do
      catalog.prices[product.name]
    end
  end
end
