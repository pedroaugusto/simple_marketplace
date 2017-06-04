module SimpleMarketplace::Offerable

  # Every new offer/promotion will have to implement this method
  # in order to execute its promotional rules.
  def call(items, total)
    raise "Must implement"
  end
end