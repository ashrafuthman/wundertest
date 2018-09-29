require_relative "product"
require "test/unit"

class TestCheckout < Test::Unit::TestCase

  curry_sauce = {product_code: 001, name: 'Curry Sauce', price: 1.95}
  pizza = {product_code: 002, name: 'Pizza', price: 5.99}
  men_tshirt = {product_code: 003, name: 'Men T-Shirt', price: 25.00}

	def test_checkout
		assert_equal(9.93 ,Checkout.new(promotional_rules).scan(pizza, curry_sauce, pizza), price = Checkout.total)
	end
end