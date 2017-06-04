module SimpleMarketplace::Offer
  class TotalPercentageDiscountByMinValue
    include ::SimpleMarketplace::Offerable

    def initialize(min_value, percentage)
      @min_value, @percentage = min_value, percentage
    end

    # Applies the percentage discount if total is greater than min_value
    def call(items, total)
      total >= @min_value ? total.mult(BigDecimal.new(100).sub(@percentage, 4), 4).div(BigDecimal.new(100), 4) : total
    end
  end
end