$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "simple_marketplace"

# Let's create some products here...
SimpleMarketplace::Product.create(
    { code: "001", name: "Lavender Heart", price: BigDecimal.new("9.25") },
    { code: "002", name: "Personalised cufflinks", price: BigDecimal.new("45", 4) },
    { code: "003", name: "Kids T-shirt", price: BigDecimal.new("19.95", 4) })


# Offering a discount to a specifc product
offer1 = SimpleMarketplace::Offer::ProductDiscountByAmount.new('001', 2, BigDecimal.new(8.5, 4))

# Offering discount in the entire order
offer2 = SimpleMarketplace::Offer::TotalPercentageDiscountByMinValue.new(BigDecimal.new(60.01, 4), 10)

# Adding the discounts to this checkout
co = SimpleMarketplace::Checkout.new(offer1, offer2)

# Adding products
co.scan("001")
co.scan("002")
co.scan("003")

# reading the total
puts "Basket 001,002,003"
puts co.pretty_total

# empty basket
co.clear_items

# Adding products
co.scan("001")
co.scan("003")
co.scan("001")

# reading the total
puts "Basket 001,003,001"
puts co.pretty_total

# empty basket
co.clear_items

# Adding products
co.scan("001")
co.scan("002")
co.scan("001")
co.scan("003")

# reading the total
puts "Basket 001,002,001,003"
puts co.pretty_total
