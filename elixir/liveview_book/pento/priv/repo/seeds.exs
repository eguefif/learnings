# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.{Accounts, Catalog}

{:ok, user} =
  Accounts.register_user(%{
    username: "Harry Potter",
    email: "HarryPotter@example.com",
    password: "password123password123"
  })

scope = Pento.Accounts.Scope.for_user(user)

products = [
  %{
    name: "Chess",
    description: "The classic strategy game",
    unit_price: 10.00,
    sku: 5_678_910
  },
  %{
    name: "Checkers",
    description: "The classic board game",
    unit_price: 8.00,
    sku: 1_234_567
  },
  %{
    name: "Backgammong",
    description: "An ancient strategy game",
    unit_price: 15.00,
    sku: 9_876_543
  }
]

Enum.each(products, fn product_attrs ->
  {:ok, product} = Catalog.create_product(scope, product_attrs)
  IO.puts("Created product: #{product.name}")
end)
