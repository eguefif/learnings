from model_objects import Discount, Offer, Product, ProductUnit, SpecialOfferType
from receipt import Receipt
from shopping_cart import ShoppingCart

from .fake_catalog import FakeCatalog

import pytest

@pytest.fixture
def catalog():
    return FakeCatalog()

@pytest.fixture
def cart_with_two_items():
    catalog = FakeCatalog()
    product_apple = Product("Apple", ProductUnit.KILO)
    product_soap = Product("SOAP", ProductUnit.EACH)
    catalog.add_product(product_apple, 5.0)
    catalog.add_product(product_soap, 10.0)
    cart = ShoppingCart()
    cart.add_item(product_apple)
    cart.add_item(product_soap)
    return cart

def cart_with_one_item():
    catalog = FakeCatalog()
    product_apple = Product("Apple", ProductUnit.KILO)
    catalog.add_product(product_apple, 5.0)
    cart = ShoppingCart()
    cart.add_item(product_apple)
    return cart

def test_handle_offers_no_offer(cart_with_two_item):
    # Fixture
    receipt = Receipt()
    cart_with_two_item.handle_offers(receipt, {}, catalog)
    assert len(receipt.discounts) == 0


def test_handle_offers_ten_percent_off():
    # Fixture
    catalog = FakeCatalog()
    product = Product("Apple", ProductUnit.KILO)
    catalog.add_product(product, 5.0)
    offer = Offer(SpecialOfferType.TEN_PERCENT_DISCOUNT, product, 10.0)
    cart = ShoppingCart()
    receipt = Receipt()
    cart.add_item(product)

    cart.handle_offers(receipt, {product: offer}, catalog)

    expected_discount = Discount(product, "% off", 0.5)

    assert len(receipt.discounts) == 1
    assert receipt.discounts[0].product == expected_discount.product
    assert receipt.discounts[0].discount_amount == -expected_discount.discount_amount
    assert receipt.discounts[0].product == expected_discount.product


def test_handle_offers_ten_percent_off_two_products():
    # Fixture
    catalog = FakeCatalog()
    product_apple = Product("Apple", ProductUnit.KILO)
    product_soap = Product("SOAP", ProductUnit.EACH)
    catalog.add_product(product_apple, 5.0)
    catalog.add_product(product_soap, 10.0)
    offer_apple = Offer(SpecialOfferType.TEN_PERCENT_DISCOUNT, product_apple, 10.0)
    offer_soap = Offer(SpecialOfferType.TEN_PERCENT_DISCOUNT, product_apple, 10.0)
    cart = ShoppingCart()
    receipt = Receipt()
    cart.add_item(product_apple)
    cart.add_item(product_soap)

    cart.handle_offers(
        receipt, {product_apple: offer_apple, product_soap: offer_soap}, catalog
    )

    expected_discount_apple = Discount(product_apple, "% off", 0.5)
    expected_discount_soap = Discount(product_soap, "% off", 1.0)

    assert len(receipt.discounts) == 2

    # Assert Apple
    assert receipt.discounts[0].product == expected_discount_apple.product
    assert (
        receipt.discounts[0].discount_amount == -expected_discount_apple.discount_amount
    )
    assert receipt.discounts[0].product == expected_discount_apple.product

    # Assert Soap
    assert receipt.discounts[1].product == expected_discount_soap.product
    assert (
        receipt.discounts[1].discount_amount == -expected_discount_soap.discount_amount
    )
    assert receipt.discounts[1].product == expected_discount_soap.product

def test_three_for_two_offer():

