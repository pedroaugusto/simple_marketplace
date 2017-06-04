require 'spec_helper'

RSpec.describe SimpleMarketplace::Checkout do

  describe "scan" do

    let(:checkout) { SimpleMarketplace::Checkout.new }

    context "when the product code is set" do
      before { SimpleMarketplace::Product.create(code: "001", name: "twix", price: BigDecimal.new("1.10")) }

      it "adds product to items list" do
        checkout.scan("001")
        expect(checkout.instance_variable_get(:@items)).to eq([SimpleMarketplace::Product.new("001", "twix", BigDecimal.new("1.10"))])
      end
    end

    context "when the product code is not set" do
      it "let the items list empty" do
        checkout.scan("002")
        expect(checkout.instance_variable_get(:@items)).to be_empty
      end
    end

  end

  describe "total" do

    context "when there aren't rules set" do
      let(:checkout) { SimpleMarketplace::Checkout.new }

      before do
        items = [
          double("item1", price: BigDecimal("1.01")),
          double("item2", price: BigDecimal("2.21")),
          double("item3", price: BigDecimal("3.33")),
          double("item4", price: BigDecimal("0.01"))
        ]

        checkout.instance_variable_set(:@items, items)
      end

      it "Just return the items sum" do
        expect(checkout.total).to eq(BigDecimal.new("6.56"))
      end
    end

    context "when there are rules set" do

      let(:rule1) { double "rule1" }
      let(:rule2) { double "rule2" }
      let(:rule3) { double "rule3" }

      before do
        allow(rule1).to receive(:call).and_return(BigDecimal.new("10"))
        allow(rule2).to receive(:call).and_return(BigDecimal.new("20"))
        allow(rule3).to receive(:call).and_return(BigDecimal.new("30"))

        @checkout = SimpleMarketplace::Checkout.new(rule1, rule2, rule3)

        items = [
          double("item1", price: BigDecimal("1.01")),
          double("item2", price: BigDecimal("2.21")),
          double("item3", price: BigDecimal("3.33")),
          double("item4", price: BigDecimal("0.01"))
        ]

        @checkout.instance_variable_set(:@items, items)
      end

      it "it returns the last rule result" do
        expect(@checkout.total).to eq(BigDecimal.new("30"))
      end

    end
  end

  describe "pretty_total" do
    let(:checkout) { SimpleMarketplace::Checkout.new }
    before { allow(checkout).to receive(:total).and_return(BigDecimal.new("12.3456")) }

    it "return string formated as money" do
      expect(checkout.pretty_total).to eq("£12.35")
    end
  end

end