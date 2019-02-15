#require "json"

class Item
  attr_reader :items

  def initialize
    @items = read_data
  end

  def read_data
    f = File.read("./item_data.json")
    JSON.parse(f)
  end
end
