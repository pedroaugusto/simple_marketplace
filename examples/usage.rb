$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "simple_marketplace"


# Let's create some products here...
SimpleMarketplace::Product.create(
    { code: "001", name: "Lavender Heart", price: BigDecimal.new("9.25") },
    { code: "002", name: "Personalised cufflinks", price: BigDecimal.new("45", 4) },
    { code: "003", name: "Kids T-shirt", price: BigDecimal.new("19.95", 4) })


offer1 = SimpleMarketplace::Offer::ProductDiscountByAmount.new('001', 2, BigDecimal.new(8.5, 4))
offer2 = SimpleMarketplace::Offer::TotalPercentageDiscountByMinValue.new(BigDecimal.new(60.01, 4), 10)

co = SimpleMarketplace::Checkout.new(offer1, offer2)

co.scan("001")
co.scan("003")
co.scan("002")
co.scan("001")

puts co.pretty_total
