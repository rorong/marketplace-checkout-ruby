# frozen_string_literal: true

class Product
  attr_accessor :product_code, :name, :unit_price

  def initialize(product_code, name, unit_price)
    @product_code = product_code
    @name = name
    @unit_price = unit_price
  end
end
