
class Produkt

  #showing discount type scentance would be nice
  #the name is lost when added to the arr so a name param is needed
  def initialize(name, baseprice, discnr)
      @name =  name
      @baseprice = baseprice       
      @discnr = discnr      
  end
#forgot end 
  def name
    @name
  end
  def baseprice
    @baseprice
  end
  def discnr
    @discnr  
  end


 

end
