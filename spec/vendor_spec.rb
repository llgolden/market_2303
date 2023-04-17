require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  it "exists" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    expect(vendor).to be_a(Vendor)
  end

  it "has an attribute" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    expect(vendor.name).to eq("Rocky Mountain Fresh")  
  end

 xit "has can hold inventory" do
    vendor = Vendor.new("Rocky Mountain Fresh")

    
    expect(vendor.inventory).to eq({})  
    expect(vendor.check_stock(item1)).to eq(0)  
    vendor.stock(item1, 30)
    expect(vendor.inventory).to eq({
      item1 => 30
    })  
    expect(vendor.check_stock(item1)).to eq(30)  
    vendor.stock(item1, 25)
    expect(vendor.check_stock(item1)).to eq(55)  
    vendor.stock(item2, 12)
    expect(vendor.inventory).to eq({
      item1 => 30, 
      item2 => 12
    })      
  end

end #final

# Any item not in stock should return `0` by default.
