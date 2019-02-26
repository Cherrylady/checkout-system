require "json"
require_relative "basket"
require_relative "item"

class CheckOut
  def initialize(rules)
    @rules = rules
    @items = Item.load_all
    @basket = Basket.new
  end

  def scan(item_name)
    @basket.container << @items.find {|item| item.name == item_name }
  end

  def total
    total_price = []

    @basket.container.map do |item|
      total_price << item.price
    end
    @rules.each do |rule|
      quantity = @basket.quantity(rule[:item_name])
      rule_number =  quantity / rule[:quantity]
      rule_number.times do
        total_price << rule[:discount]
      end
    end
    total_price.sum
  end
end

co = CheckOut.new([{item_name: "A", quantity: 3, discount: -20}, {item_name: "B", quantity: 2, discount: -15}])
p co.scan("A")
p co.total
