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

  # def potential_revenue

  # end

end #final


# A Vendor will be able to calculate their `potential_revenue` - the sum of all their items' price * quantity.



# Additionally, the Market should have a method called `vendors_that_sell` that takes an argument of an item. It will return a list of Vendors that have that item in stock.

