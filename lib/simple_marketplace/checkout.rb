module SimpleMarketplace
  class Checkout

    def initialize(*promotional_rules)
      @promotional_rules = promotional_rules
      @itens = []
    end

    # Adds an item to the cart
    def scan(product_code)
      if (product = Product.get_by_code(product_code))
        @itens << product
      end
    end

    # Calculates the total with promotions applied
    def total
      @total = @itens.map(&:price).reduce(:+)
      apply_promotional_rules
      @total
    end

    # Shows the formated total
    def pretty_total
      "£#{'%.2f' % total}"
    end

    private

    # calls the promotional rules in order
    def apply_promotional_rules
      @promotional_rules.each do |rule|
        @total = rule.call(@itens, @total)
      end
    end

  end
end