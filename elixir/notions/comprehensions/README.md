# Elixir — Comprehensions Exercise

Generated with Claude

## Setup

Work in IEx or create a `comprehensions.exs` file and run it with `elixir comprehensions.exs`.

## Dataset

```elixir
orders = [
  %{item: "book",  qty: 3,  price: 12},
  %{item: "pen",   qty: 10, price: 2},
  %{item: "desk",  qty: 1,  price: 150},
  %{item: "lamp",  qty: 2,  price: 35},
  %{item: "cable", qty: 0,  price: 8},
]
```

## Tasks

### 1. Filter active orders *(warm-up)*

Extract only orders where `qty > 0`. The result should be a list of maps.

<details>
<summary>Hint</summary>

Use a filter guard after the generator:

```elixir
for order <- orders, order.qty > 0 do
  ...
end
```

</details>

---

### 2. Build `{item, total_price}` tuples *(warm-up)*

Produce a list of `{item, total_price}` tuples, but only for orders whose total price (qty × price) exceeds 20.

<details>
<summary>Hint</summary>

Compute `order.qty * order.price` inside the `do` block and filter on that computed value using a guard.

</details>

---

### 3. Produce a map of `item → total_price` using `into:` *(stretch)*

Same computation as task 2 (no filter this time), but instead of a list of tuples, return a map.

<details>
<summary>Hint</summary>

Pass `into: %{}` as an option to the comprehension. Your `do` block should return a `{key, value}` tuple.

```elixir
for order <- orders, into: %{} do
  ...
end
```

</details>

---

### 4. Cartesian product with a filter *(stretch)*

Pair each order with each of `[:new, :used]` to produce `{item, condition}` tuples. Skip pairs where `qty` is 0.

<details>
<summary>Hint</summary>

Use two generators — multiple generators produce the cartesian product:

```elixir
for order <- orders, condition <- [:new, :used], order.qty > 0 do
  ...
end
```

</details>

---

## Expected results

| Task | Result |
|------|--------|
| 1 | List of 4 maps (cable excluded) |
| 2 | `[{"book", 36}, {"desk", 150}, {"lamp", 70}]` |
| 3 | `%{"book" => 36, "pen" => 20, "desk" => 150, "lamp" => 70, "cable" => 0}` |
| 4 | 8 tuples (4 active orders × 2 conditions) |
