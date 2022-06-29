# frozen_string_literal: true

class PricingRule
  OVERALL_DISCOUNT = { discount_percentage: 10, total_threshold: 60 }.freeze

  attr_accessor :product_code, :offer_quantity, :original_unit_price, :discounted_unit_price

  # product_code the code of the product for which the offer is defined
  # discounted_unit_price the unit price to be paid pay when you pay in bulk 
  # offer_quantity is the number of products on which discounted_unit_price will be applied
  # By default if there is not pricing rule for any product then original_unit_price and discounted_unit_price would be same
  # Eg: - When you buy 2 or more travel card holders then the price drops to $8.50, Original Price was $9.25
  def initialize(product_code, offer_quantity, original_unit_price, discounted_unit_price)
    @product_code          = product_code
    @offer_quantity        = offer_quantity
    @original_unit_price   = original_unit_price
    @discounted_unit_price = discounted_unit_price
  end

  # Calculate price after applying price rules for the products quantity
  def price_for(quantity)
    total = if quantity >= @offer_quantity
      @discounted_unit_price * quantity
    else
      @original_unit_price * quantity
    end

    return total
  end
end
