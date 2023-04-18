class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendor_names = []
    @vendors.each do |vendor|
      vendor_names << vendor.name
    end
    vendor_names
  end

  def vendors_that_sell(item)
    vendor_sells = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        vendor_sells << vendor
      end
    end
    vendor_sells
  end

# kat answer:
  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end.uniq.sort
  end

  # def sorted_item_list
  #   items_list = []
  #   item_names = []
  #   @vendors.each do |vendor|
  #     items_list << vendor.inventory.keys
  #     items_list.flatten
  #     items_list.each do |item|
  #       item_names << item.names
  #       require 'pry'; binding.pry

  #     end
  #   end
  # end
# This method requires nested iteration. If I had more time I would have completed the method by iterating through the inventory hash for each vendor and pulled out all of the item names. Once I had an array of all the item names I would have removed the duplicates (using .uniq) and then sorted the list alphabetically 

# kat answer:
  def total_inventory
    total = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if total[item] 
          total[item][:quantity] += quantity
        else 
          total[item] = {
            quantity: quantity,
            vendors: vendors_that_sell(item)
          }
        end
      end
    end
    total
  end
# If I had more time I would have used the sorted_item_list to create the keys for the hash then I would have iterated through each vendor's inventory to pull out the quantity of each item in stock and each vendor name that sells each item to create the sub-hash values. 

# kat answer:
  def overstocked_items
    total_inventory.select do |item, info|
      info[:quantity] > 50 && info [:vendors].length > 1
    end.keys
  end

  # def overstocked_items
  #   overstocked = total_inventory.select do |item, info|
  #     info[:quantity] > 50 && info [:vendors].length > 1
  #   end
  #     overstocked.keys
  # end
# If I had more time, I would have iterated through the total_inventory hash to identify items that are sold by more than one vendor and (&&) have a quantity > 50
end 
