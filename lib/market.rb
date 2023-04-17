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

  def sorted_item_list
    
  end
# An array of the names of all items the Vendors have in stock, sorted alphabetically. This list should not include any duplicate items.

  def total_inventory

  end
#it should return a hash with items as keys and hashes as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and vendors pointing to an array of the vendors that sell that item. 


  def overstocked_items

  end
  
# An array of Item objects that are overstocked. An item is overstocked if it is sold by more than 1 vendor AND the total quantity is greater than 50.

end #final
