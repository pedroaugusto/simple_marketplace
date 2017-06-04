require 'spec_helper'

RSpec.describe SimpleMarketplace::Product do

  subject(:create_3_products) do
    SimpleMarketplace::Product.create(
    { code: "001", name: "Lavender Heart", price: BigDecimal.new("9.25") },
    { code: "002", name: "Personalised cufflinks", price: BigDecimal.new("45") },
    { code: "003", name: "Kids T-shirt", price: BigDecimal.new("19.95") })
  end

  describe "create" do

    it "should store 3 entries" do
      expect{ create_3_products }.to change{ SimpleMarketplace::Product.class_variable_get(:@@all).size }.by(3)
    end

    it "should store product instances" do
      create_3_products
      items = SimpleMarketplace::Product.class_variable_get(:@@all).values
      expect(items.select{|p| p.is_a?(SimpleMarketplace::Product)}.size).to eq(3)
    end

    it "should map the products with their codes" do
      create_3_products
      SimpleMarketplace::Product.class_variable_get(:@@all).each do |code, product|
        expect(code).to eq(product.code)
      end
    end

  end

  describe "get_by_code" do

    let(:product) { SimpleMarketplace::Product.new("004", "12 eggs box", BigDecimal.new("2")) }

    before { SimpleMarketplace::Product.create(code: product.code, name: product.name, price: product.price) }

    context "when the code is mapped in products database" do
      it "should return the product" do
        expect(SimpleMarketplace::Product.get_by_code("004")).to eq(product)
      end
    end

    context "when the code is not mapped in products database" do
      it "should return nil" do
        expect(SimpleMarketplace::Product.get_by_code("008")).to be_nil
      end
    end

  end

end