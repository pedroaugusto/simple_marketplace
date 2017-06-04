require 'spec_helper'

RSpec.describe SimpleMarketplace::Offer::ProductDiscountByAmount do

  describe "call" do

    context "when offer Snickers costing 17 cents in buying 20 or more" do

      before do
        SimpleMarketplace::Product.create(code: "100", name: "Snickers", price: BigDecimal.new("0.90"))
      end

      let(:offer) { SimpleMarketplace::Offer::ProductDiscountByAmount.new("100", 20, BigDecimal.new("0.17")) }
      let(:snicker) { double("snicker", code:"100", price: BigDecimal("0.91") ) }

      context "when items amount is less than 20" do

        let(:total) { BigDecimal.new("9.10") }

        before do
          @items = []
          10.times { @items << snicker }
        end

        it { expect(offer.call(@items, total)).to eq(total) }
      end

      context "when items amount is equal to 20" do
        let(:total) { BigDecimal.new("18.20") }
        let(:new_total) { BigDecimal.new("3.40") }

        before do
          @items = []
          20.times { @items << snicker }
        end

        it { expect(offer.call(@items, total)).to eq(new_total) }
      end

      context "when items amount is greater than 20" do
        let(:total) { BigDecimal.new("441.90") }
        let(:new_total) { BigDecimal.new("83.47") }

        before do
          @items = []
          491.times { @items << snicker }
        end

        it { expect(offer.call(@items, total)).to eq(new_total) }
      end

    end

  end

end