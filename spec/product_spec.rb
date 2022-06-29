# frozen_string_literal: true

require_relative '../app/product'

describe Product do
  before do
    @product = Product.new('001', 'Travel Card Holder', 9.25)
  end

  it 'has a product_code' do
    expect(@product.product_code).to eq '001'
  end

  it 'has a product name' do
    expect(@product.name).to eq 'Travel Card Holder'
  end

  it 'has a product unit_price' do
    expect(@product.unit_price).to eq 9.25
  end
end
