require "json"

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.load_all
    f = File.read("./item_data.json")
    JSON.parse(f).map{ |item| Item.new(item["name"], item["price"]) }
  end
end
