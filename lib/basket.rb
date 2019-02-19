class Basket
  attr_reader :container

  def initialize
    @container = []
  end

  def quantity(item_name)
    @container.select { |item| item.name == item_name }.count
  end
end
