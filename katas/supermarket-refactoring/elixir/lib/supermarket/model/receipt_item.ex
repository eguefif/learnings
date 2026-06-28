defmodule Supermarket.Model.ReceiptItem do
  defstruct [:product, :quantity, :price, :total_price]

  def new(product, quantity, price, total_price) do
    %__MODULE__{product: product, quantity: quantity, price: price, total_price: total_price}
  end

  defimpl String.Chars, for: Supermarket.Model.ReceiptItem do
    def to_string(receipt_item) do
      "Item #{receipt_item.product}, quantity: #{receipt_item.quantity}, price: #{receipt_item.price}, total_price: #{receipt_item.total_price}"
    end
  end
end
