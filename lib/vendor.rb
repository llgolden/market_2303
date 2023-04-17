class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, num)
    @inventory[item] += num
  end

  def potential_revenue
    @inventory.map do |item|
      item_price = item[0].price
      quantity = item.pop
      rev = (item_price * quantity).sum
    end
    rev
    require 'pry'; binding.pry
  end
    # require 'pry'; binding.pry
 
    # (item.price * quantity) + (item.price * quantity)


  # A Vendor will be able to calculate their `potential_revenue` - the sum of all their items' price * quantity.

end #final



    # @inventory.find do |items|
    #   items.name == item
    # end
    # item.value
