require "json"
require_relative "basket"
require_relative "item"

class CheckOut

  def initialize(rules)
    @items = read_data
    @basket = []
    @rules = rules
  end

  def scan(item_name)
    @basket << @items.select { |item| item["name"] == item_name }.first
  end

  def total
    prices = []

    @basket.each do |item|
      prices << item["price"]
    end
    @rules.each do |rule|
      quantity = @basket.select { |item| item["name"] == rule[:item_name] }.count
      rule_number = quantity / rule[:quantity]
      rule_number.times do
        prices << rule[:discount]
      end
    end
    prices.sum
  end

  def read_data
    f = File.read("./item_data.json")
    JSON.parse(f)
  end
end

co = CheckOut.new([{item_name: "A", quantity: 3, discount: -20}, {item_name: "B", quantity: 2, discount: -15}])
puts co.scan("A")
puts co.total
