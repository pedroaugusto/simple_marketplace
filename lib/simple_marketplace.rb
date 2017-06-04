require "simple_marketplace/version"
require "bigdecimal"

module SimpleMarketplace
  autoload :Product,   'simple_marketplace/product'
  autoload :Offerable, 'simple_marketplace/offerable'
  autoload :Checkout,  'simple_marketplace/checkout'

  module Offer
    autoload :ProductDiscountByAmount,           'simple_marketplace/offer/product_discount_by_amount'
    autoload :TotalPercentageDiscountByMinValue, 'simple_marketplace/offer/total_percentage_discount_by_min_value'
  end
end
