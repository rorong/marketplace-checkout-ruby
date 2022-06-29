# frozen_string_literal: true

class Checkout
  # pricing_rules as an set of PricingRule objects for all products
  def initialize(pricing_rules=Array.new)
    @pricing_rules = pricing_rules
    @products = Array.new
  end

  # product to be bought
  def scan(product)
    @products << product
  end

  # Calculates the total price after applying pricing rules
  def total
    total = 0.0
    # apply each pricing rule all products
    @pricing_rules.each do |pricing_rule|
      product_code = pricing_rule.product_code

      products = @products.select {|i| i.product_code == product_code}

      total += pricing_rule.price_for products.count
    end

    # Ensure if the total amount is applicable to get overall discount
    if total >= PricingRule::OVERALL_DISCOUNT[:total_threshold]
      overall_discount = (total * PricingRule::OVERALL_DISCOUNT[:discount_percentage]) / 100

      total -= overall_discount
    end


    return total
  end
end