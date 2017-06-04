module SimpleMarketplace
  class Product
    attr_reader :code, :name, :price

    @@all = Hash.new

    def initialize(code, name, price)
      @code, @name, @price = code, name, price
    end

    # Fills the products database
    def self.create(*args)
      args.each do |hash|
        @@all[hash[:code]] = Product.new(hash[:code], hash[:name], hash[:price])
      end
    end

    # returns product with the code
    def self.get_by_code(code)
      @@all[code]
    end

    # pretty print
    def to_s
      "Product(code: #{@code}, name: #{@name}, price: #{@price})"
    end

    # checks equality
    def ==(other)
      return code == other.code, name == other.name, price: other.price
    end

  end
end