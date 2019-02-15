require "json"
require_relative "basket"
require_relative "item"

class CheckOut

  def initialize(rules)
    @items = Item.new
    @basket = Basket.new
    @rules = rules
  end

  def scan(item_name)
    @basket.basket << @items.items.select { |item| item["name"] == item_name }.first
  end

  def total
    prices = []

    @basket.basket.each do |item|
      prices << item["price"]
    end
    @rules.each do |rule|
      quantity = @basket.basket.select { |item| item["name"] == rule[:item_name] }.count
      rule_number = quantity / rule[:quantity]
      rule_number.times do
        prices << rule[:discount]
      end
    end
    prices.sum
  end
end
