defmodule Supermarket do
  alias Supermarket.Model.Teller
  alias Supermarket.Model.Teller
  alias Supermarket.Model.Catalog
  alias Supermarket.Model.SupermarketCatalog
  alias Supermarket.Model.Product
  alias Supermarket.Model.ShoppingCart

  @gm_filename "golden_master.txt"

  # TODO: create extensive test to cover all path
  # - [ ]Add a diff string for check golden master
  # - [ ] Discount
  # - [ ] Different types of unit
  # Explore the code to check all path
  def save_golden_master() do
    File.write!(@gm_filename, get_content())
  end

  def check_golden_master() do
    content = get_content()
    golden_master = File.read!(@gm_filename)

    if content == golden_master do
      IO.puts("Passed")
    else
      IO.puts("Failed")
      File.write!("tmp.file", content)
      {result, _status} = System.cmd("diff", ["tmp.file", @gm_filename])
      IO.puts(result)
      System.cmd("rm", ["tmp.file"])
    end
  end

  defp get_content() do
    toothbrush = Product.new("toothbrush", :each)
    apples = Product.new("apples", :kilo)

    catalog =
      Catalog.new()
      |> SupermarketCatalog.add_product(toothbrush, 0.99)
      |> SupermarketCatalog.add_product(apples, 1.99)

    teller =
      catalog
      |> Teller.new()
      |> Teller.add_special_offer(:ten_percent_discount, toothbrush, 10.0)

    cart = ShoppingCart.new() |> ShoppingCart.add_item_quantity(apples, 2.5)
    receipt = Teller.checks_out_articles_from(teller, cart)
    "#{receipt}"
  end
end
