defmodule Supermarket do
  alias Supermarket.Model.Teller
  alias Supermarket.Model.Teller
  alias Supermarket.Model.Catalog
  alias Supermarket.Model.SupermarketCatalog
  alias Supermarket.Model.Product
  alias Supermarket.Model.ShoppingCart

  @gm_filename "golden_master.txt"

  # TODO: create extensive test to cover all path
  # - [ ] Add a diff string for check golden master
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
    rice = Product.new("rice", :kilo)
    toothpaste = Product.new("apples", :each)
    cherry = Product.new("apples", :kilo)
    tv = Product.new("apples", :kilo)
    computer = Product.new("apples", :kilo)
    pants = Product.new("pants", :each)
    table = Product.new("table", :each)
    chair = Product.new("chair", :each)
    sofa = Product.new("sofa", :each)

    catalog =
      Catalog.new()
      |> SupermarketCatalog.add_product(toothbrush, 0.99)
      |> SupermarketCatalog.add_product(apples, 1.99)
      |> SupermarketCatalog.add_product(toothpaste, 3.42)
      |> SupermarketCatalog.add_product(tv, 332.42)
      |> SupermarketCatalog.add_product(computer, 1554.42)
      |> SupermarketCatalog.add_product(pants, 23.3)
      |> SupermarketCatalog.add_product(table, 55.3)
      |> SupermarketCatalog.add_product(chair, 33.3)
      |> SupermarketCatalog.add_product(sofa, 10.4)
      |> SupermarketCatalog.add_product(rice, 5.3)

    teller =
      catalog
      |> Teller.new()
      |> Teller.add_special_offer(:ten_percent_discount, apples, 10.0)
      |> Teller.add_special_offer(:ten_percent_discount, rice, 10.0)
      |> Teller.add_special_offer(:three_for_two, pants, nil)
      |> Teller.add_special_offer(:three_for_two, table, nil)
      |> Teller.add_special_offer(:two_for_amount, tv, 500.1)
      |> Teller.add_special_offer(:two_for_amount, chair, 500.1)
      |> Teller.add_special_offer(:five_for_amount, computer, 5000.32)
      |> Teller.add_special_offer(:five_for_amount, sofa, 5000.32)

    cart =
      ShoppingCart.new()
      |> ShoppingCart.add_item_quantity(rice, 4.5)
      |> ShoppingCart.add_item_quantity(cherry, 1.5)
      |> ShoppingCart.add_item_quantity(cherry, 2.5)
      |> ShoppingCart.add_item_quantity(apples, 15.5)
      |> ShoppingCart.add_item_quantity(pants, 3)
      |> ShoppingCart.add_item_quantity(table, 2)
      |> ShoppingCart.add_item_quantity(tv, 2)
      |> ShoppingCart.add_item_quantity(chair, 1)
      |> ShoppingCart.add_item_quantity(computer, 5)
      |> ShoppingCart.add_item_quantity(sofa, 5)
      |> ShoppingCart.add_item_quantity(apples, 2.5)

    receipt = Teller.checks_out_articles_from(teller, cart)
    "#{receipt}"
  end
end
