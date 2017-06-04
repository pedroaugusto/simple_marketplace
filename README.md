# SimpleMarketplace

Ruby gem that operates simple checkout cart operations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_marketplace'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_marketplace

## Usage

Create some products

```ruby
# Let's create some products here...
SimpleMarketplace::Product.create(
    { code: "001", name: "Lavender Heart", price: BigDecimal.new("9.25") },
    { code: "002", name: "Personalised cufflinks", price: BigDecimal.new("45", 4) },
    { code: "003", name: "Kids T-shirt", price: BigDecimal.new("19.95", 4) })
```

Create a checkout basket and add items to it

```ruby
co = SimpleMarketplace::Checkout.new

co.scan("001")
co.scan("002")
co.scan("001")
```

Check the total

```ruby
co.pretty_total
=> £36.95
```

Customize promotions

```ruby

promotion = SimpleMarketplace::Offer::ProductDiscountByAmount.new('001', 2, BigDecimal.new("8.50"))
co = SimpleMarketplace::Checkout.new(promotion)
```

## Development

- `bin/setup` to install dependencies;
- `rake spec` to run the tests;
- `bin/console` for an interactive prompt that will allow you to experiment.
- `ruby examples/usage` to see this gem in action (check the source).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pedroaugustosb/simple_marketplace.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
