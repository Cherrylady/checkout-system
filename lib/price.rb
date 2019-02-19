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
    @basket.container << @items.select {|item| item.name == item_name }.first
  end

  def total
    total_price = []

    @basket.container.flatten.each do |item|
      total_price << item.price
    end
    @rules.each do |rule|
      rule[:item_name]
      quantity = @basket.quantity(rule[:item_name])
      rule_number =  quantity / rule[:quantity]
      rule_number.times do
        total_price << rule[:discount]
      end
    end
    total_price.sum
  end
end
