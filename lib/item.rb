class Item
  attr_reader :items

  def initialize
    @items = read_data
  end

  def item
    @items.select { |item| item["name"]}.first
  end

  def read_data
    f = File.read("../item_data.json")
    JSON.parse(f)
  end
end
