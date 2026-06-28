defmodule Supermarket.Model.Discount do
  defstruct [:product, :description, :discount_amount]

  alias Supermarket.Model.Discount

  def new(product, description, discount_amount) do
    %__MODULE__{product: product, description: description, discount_amount: discount_amount}
  end

  defimpl String.Chars, for: Supermarket.Model.Discount do
    def to_string(%Discount{} = discount) do
      "Discount `#{discount.description}` for #{discount.product}: #{discount.discount_amount}"
    end
  end
end
