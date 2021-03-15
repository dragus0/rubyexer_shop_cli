# class Product < MCl_ShopItem
class Product

  def initialize(name, price)
      # super(name, price)
      @name =  name
      @price = price 
  end

  attr_accessor :name, :price
   
end


# class Shop_product < Product
  
#   def initialize(name, price, discount_nr, quantity)
#     super(name, price, discount_nr)
#     @quantity = Integer(quantity)
#     @price_saved = getfinprice
#   end

#   attr_reader :name, :price, :discount_nr, :quantity
  
# end


class Discount

  # // 02/23/2021 11:46:19 Dragus Aexandru :-  so to ensure a different property when i flatten the array Name would appear twice
  def initialize(type_name, discount, quantity_bonus, quantity_condition)
      @type_name = type_name
      @discount = discount
      @quantity_bonus = quantity_bonus
      @quantity_condition = quantity_condition
  end

  attr_reader :type_name, :discount, :quantity_bonus, :quantity_condition

end

  
$products_arr= Array.new
$receipt_arr= Array.new
$shop_products_arr= Array.new
$discounts_arr = Array.new


$discounts_arr << Discount.new("buy one get one free", 0, 1, 1)
$discounts_arr << Discount.new("buy two get one free", 0, 1, 2)
$discounts_arr << Discount.new("10% off", 0.10, 0, 1)
$discounts_arr << Discount.new("20% off", 0.20, 0, 1)
$discounts_arr << Discount.new("buy five get 50% off", 0.5, 0, 5)
$discounts_arr << Discount.new("no discount", 0, 0, 1)

bread = Product.new("bread",10)
$products_arr << bread
orange = Product.new("orange",8)
$products_arr << orange
cola = Product.new("cola",3)
$products_arr << cola
cocoa = Product.new("cocoa",12)
$products_arr << cocoa
gum = Product.new("gum",2)
$products_arr << gum
apple = Product.new("apple",1)
$products_arr << apple

# // 02/23/2021 11:46:19 Dragus Aexandru :- either have 2 ARR a disount arr and a produkt arr or 1 and add bolth in it @ the same time, but 2 is more oopz
# // 02/23/2021 11:46:19 Dragus Aexandru :-  $discounts_arr[0].name this losses the property.name, so i need to add the data in another way
$shop_products_arr << {"name" => $products_arr[0].name, "price" => $products_arr[0].price, "discount" => $discounts_arr[0].type_name}
$shop_products_arr << {"name" => $products_arr[1].name, "price" => $products_arr[1].price, "discount" => $discounts_arr[1].type_name}
$shop_products_arr << {"name" => $products_arr[2].name, "price" => $products_arr[2].price, "discount" => $discounts_arr[2].type_name}
$shop_products_arr << {"name" => $products_arr[3].name, "price" => $products_arr[3].price, "discount" => $discounts_arr[3].type_name}
$shop_products_arr << {"name" => $products_arr[4].name, "price" => $products_arr[4].price, "discount" => $discounts_arr[4].type_name}
$shop_products_arr << {"name" => $products_arr[5].name, "price" => $products_arr[5].price, "discount" => $discounts_arr[5].type_name}





