module SimpleMarketplace::Offer
  class ProductDiscountByAmount
    include ::SimpleMarketplace::Offerable

    def initialize(product_code, initial_amount, new_value)
      @product_code, @initial_amount, @new_value = product_code, initial_amount, new_value
    end

    # Verify if the product amount is the desired to change the product value
    def call(items, total)
      if items.count{ |product| product.code == @product_code } >= @initial_amount
        items.collect{|product| product.code == @product_code ? @new_value : product.price }.reduce(:+)
      else
        total
      end
    end

  end
end