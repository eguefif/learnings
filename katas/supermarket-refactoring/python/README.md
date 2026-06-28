# Supermarket Receipt in [Python](https://www.python.org/)

## Setup

* Have Python installed
* Clone the repository
* On the command line, enter the `SupermarketReceipt-Refactoring-Kata/python` directory
* On the command line, install requirements, e.g. on the`python -m pip install -r requirements.txt`

## Running Tests

On the command line, enter the `SupermarketReceipt-Refactoring-Kata/python` directory and run

```
python -m unittest
```

## Optional: Running [TextTest](https://www.texttest.org/) Tests

Install TextTest according to the [instructions](https://www.texttest.org/index.html#getting-started-with-texttest) (platform specific).

On the command line, enter the `SupermarketReceipt-Refactoring-Kata/python` directory and run

```
texttest -a sr -d .
```

## Architecture

Classes:
- Teller => Has a catalog and a list of offers. Will take a ShoppingCart and return a Receipt
- Catalog => Has a list of product/per-unit-prices.
- Product => Has a name and a unit.
- ShoppingCart => Has a list of items and product_quantities. TODO: clariy what `handle_offers()` does.


Enums:
- SpecialOfferType
- ProductUnit
