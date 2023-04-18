require 'date'
class Market
  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today 
  end

  # def date
  #   @date.strftime("%d/%m/%Y")
  # end
  # ^ this will reformat the date how we want - if the stub was not there in spec line 13

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

  def sell(item, quantity)
    return false if total_inventory[item][:quantity] < quantity

    @vendors.each do |vendor|
      if vendor.check_stock(item) > quantity
        vendor.inventory[item] -= quantity
        break 
      else 
        quantity -= vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end
    return true
  end


end 
