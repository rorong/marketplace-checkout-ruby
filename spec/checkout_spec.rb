# frozen_string_literal: true

# 001 | Travel Card Holder | $9.25
# 002 | Personalised cufflinks | $45.00
# 003 | Kids T-shirt | $19.95


require_relative '../app/product'
require_relative '../app/pricing_rule'
require_relative '../app/checkout'

describe Checkout do
  describe '#total' do
    before do
      @pricing_rules = [
        PricingRule.new('001', 2, 9.25, 8.50),
        PricingRule.new('002', 1, 45.00, 45.00),
        PricingRule.new('003', 1, 19.95, 19.95)
      ]

      @total_threshold     = PricingRule::OVERALL_DISCOUNT[:total_threshold]
      @discount_percentage = PricingRule::OVERALL_DISCOUNT[:discount_percentage]
    end

    it "calculates correct price for Basket: 001,002,003" do
      products = [
        Product.new('001', 'Travel Card Holder', 9.25),
        Product.new('002', 'Personalised cufflinks', 45.00),
        Product.new('003', 'Kids T-shirt', 19.95)
      ]

      checkout = Checkout.new(@pricing_rules)

      products.each do |i|
        checkout.scan i
      end

      expected_total = (9.25 + 45.00 + 19.95)
      if expected_total >= @total_threshold
        expected_total = expected_total - (expected_total * @discount_percentage/100)
      end

      expect(checkout.total).to be( expected_total)
    end

    it "calculates correct price for Basket: 001,003,001" do
      products = [
        Product.new('001', 'Travel Card Holder', 9.25),
        Product.new('003', 'Kids T-shirt', 19.95),
        Product.new('001', 'Travel Card Holder', 9.25)
      ]

      checkout = Checkout.new(@pricing_rules)

      products.each do |i|
        checkout.scan i
      end

      expected_total = (8.50 + 19.95 + 8.50)
      if expected_total >= @total_threshold
        expected_total = expected_total - (expected_total * @discount_percentage/100)
      end 

      expect(checkout.total).to be( expected_total)
    end

    it "calculates correct price for Basket: 001,002,001,003" do
      products = [
        Product.new('001', 'Travel Card Holder', 9.25),
        Product.new('002', 'Personalised cufflinks', 45.00),
        Product.new('001', 'Travel Card Holder', 9.25),
        Product.new('003', 'Kids T-shirt', 19.95)
      ]

      checkout = Checkout.new(@pricing_rules)

      products.each do |i|
        checkout.scan i
      end

      expected_total = (8.50 + 45.00 + 8.50 + 19.95)
      if expected_total >= @total_threshold
        expected_total = expected_total - (expected_total * @discount_percentage/100)
      end 

      expect(checkout.total).to be( expected_total)
    end
  end
end
