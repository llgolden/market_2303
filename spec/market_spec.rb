require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  it "exists" do
    market = Market.new("South Pearl Street Farmers Market")
    expect(market).to be_a(Market)
  end

  it "has attributes" do
    # allow(Date).to receive(:today).and_return(Date.today.strftime("%d/%m/%Y"))
    allow(Date).to receive(:today).and_return("01/04/2023")
    # ^added in Iteration 4
    market = Market.new("South Pearl Street Farmers Market")
    expect(market.name).to eq("South Pearl Street Farmers Market")  
    expect(market.vendors).to eq([])
    # added in Iteration 4:
    expect(market.date).to eq("01/04/2023")
  end

  it "can host vendors" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)
    
    expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it "can identify vendors who sell items" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)

    expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
    expect(market.vendors_that_sell(item4)).to eq([vendor2])
  end

  it "can provide a list of items in stock" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)
    expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

it "can calculate total inventory" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)

    # expect(market.total_inventory).to eq({
    #   "Banana Nice Cream" => {
    #     quantity => 50,
    #     vendors => ["Ba-Nom-a-Nom"]
    #   }, 
    #   "Peach" => {
    #     quantity => 100,
    #     vendors => ["Rocky Mountain Fresh", "Palisade Peach Shack"]
    #   },  
    #   "Peach-Raspberry Nice Cream" => {
    #     quantity => 25,
    #     vendors => ["Ba-Nom-a-Nom"]
    #   },   
    #   "Tomato" => {
    #     quantity => 7,
    #     vendors => ["Rocky Mountain Fresh"]
    #   }
    # })
    expect(market.total_inventory).to eq({
      item1 => {
        quantity: 100, 
        vendors: [vendor1, vendor3]
      }, 
      item2 => {
        quantity: 7, 
        vendors: [vendor1]
      },
      item3 => {
        quantity: 25, 
        vendors: [vendor2]
      },
      item4 => {
        quantity: 50, 
        vendors: [vendor2]
      }
    })
  end

  it "can provide a list of overstocked items" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)

    expect(market.overstocked_items).to eq([item1])
  end

  it "can sell items" do
    market = Market.new("South Pearl Street Farmers Market")

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor3 = Vendor.new("Palisade Peach Shack")    

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    
    vendor1.stock(item1, 35)    
    vendor1.stock(item2, 7)    
    vendor2.stock(item4, 50)    
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)  

    market.add_vendor(vendor1)    
    market.add_vendor(vendor2)    
    market.add_vendor(vendor3)

    expect(market.sell(item1, 200)).to eq(false)
    expect(vendor1.check_stock(item1)).to eq(35)
    
    expect(market.sell(item1, 65)).to eq(true)
    expect(vendor1.check_stock(item1)).to eq(0)
    expect(vendor3.check_stock(item1)).to eq(35)
  end
end
