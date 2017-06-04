require 'spec_helper'

RSpec.describe SimpleMarketplace::Offer::TotalPercentageDiscountByMinValue do

  describe "call" do

    context "when offer 50% discount in orders above £40" do
      let(:offer) { SimpleMarketplace::Offer::TotalPercentageDiscountByMinValue.new(40, 50) }

      context "when items total is less than 40" do
        let(:total) { BigDecimal.new(35) }

        it { expect(offer.call(nil, total)).to eq(total) }
      end

      context "when items total is equal to 40" do
        let(:total) { BigDecimal.new(40) }

        it { expect(offer.call(nil, total)).to eq(BigDecimal.new(20)) }
      end

      context "when items total is greater than 40" do
        let(:total) { BigDecimal.new("40.02") }

        it { expect(offer.call(nil, total)).to eq(BigDecimal.new("20.01")) }
      end

    end

  end

end