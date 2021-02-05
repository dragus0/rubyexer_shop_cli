class MCl_ShopItem

  def initialize(name, price)
    @name =  name
    @price = price         
  end

  
  def name
    @name
  end

  def price
    @price
  end

end



class Produkt < MCl_ShopItem
  
  def initialize(name, price, discnr)
      super(name, price)
      # @discnr = discnr      
      @discnr = Integer(discnr)     
  end

  
  def discnr
    @discnr  
  end


  
end



class Produkt_Bought < Produkt
  
  def initialize(name, price, discnr, pquan)
    super(name, price, discnr)
    @pquan = Integer(pquan)
    @price_saved = getfinprice
  end
  
  
  def price_saved 
    @price_saved
  end
  
  def price
    @price
  end
  
  def discnr
    @discnr
  end
  
  def pquan
    @pquan
  end
  
  
  def  getfinprice
    @price_saved = Array.new
    if @pquan / $discquan[@discnr][2] >= 1
      if $discquan[@discnr][0] > 0
        @finalprice = (@price - @price * $discquan[@discnr][0]) * @pquan
        @saved =  @price * @pquan - @finalprice
      else
        # not like you buy 100 ORANGES AND THE CASHIER SAYS BUY ONE GET ONE FREE NOW U HAVE 200 ORANGES .
        @freeq=0
        @opquantity = @pquan
        while @opquantity - $discquan[@discnr][2] >= 1
          @opquantity -= $discquan[@discnr][2]
          @freeq+= $discquan[@discnr][1]
          @opquantity -= $discquan[@discnr][1]
        end
        @saved = @price * @freeq
        @finalprice = @price * (@pquan - @freeq)
      end
    else 
      puts "\nNo discount."
      @finalprice = @price * @pquan
      @saved = 0
    end
    return @price_saved << @price << @saved << @pquan
  end
  
# have another look HERE
  # self.class.getfinprice
  # @price_saved = self.class.getfinprice
  # @price_saved = getfinprice

end


=begin 
class Discount

  def initialize(nr, name, discount, quantity_bonus, quantity_cond)
    @nr = nr
    @name = name
    @discount = discount
    @quantity_bonus = quantity_bonus
    @quantity_cond = quantity_cond
  end


  def nr
    nr
  end
  
  def name
    name
  end
  
  def discount
    discount
  end
  
  def quantity_bonus
    quantity_bonus
  end
  
  def quantity_cond
    quantity_cond
  end
  

  def makeoffer (prodname, discnr, price, quantity)
    #search db in this case arr for discnr
    # disc_encoded.search?
    # @check = 
    # quantity_bonus = prod_arr.search(prodname).quantity % quantity condition
    # 2 purposes 1 checking 2 calculating
    # ((quantity_bonus = prod_arr.search(prodname).quantity % quantity condition) > 0 )? finalprice = price - price *discount; saved = price *discount + 
  end
end
=end

$discquan = 
  [   # discount, quantity bonus, quantity condition
    [0,0,1], #avoid div by 0
    [0,1,1], #Buy One Get One Free
    [0,1,2], #Buy Two Get One Free
    [0.5,0,5], #Buy 5 To Get 50% off
    [0.1,0,1], #10% off
    [0.25,0,1] #25% off
  ]
  
  $disctext = Hash[
    0 => "No discount",
    1 => "Buy One get One free",
    2 => "Buy Two get One Free",
    3 => "Buy Five to get 50% Off",
    4 => "10% Off",
    5 => "25% Off"
                  ]
  


$produkts_arr= Array.new
$produkts_b_arr= Array.new

x = Produkt_Bought.new(1,2,3,4)

bread = Produkt.new("bread",10,5)
$produkts_arr << bread
orange = Produkt.new("orange",8,1)
$produkts_arr << orange
cola = Produkt.new("cola",3,2)
$produkts_arr << cola
cocoa = Produkt.new("cocoa",12,3)
$produkts_arr << cocoa