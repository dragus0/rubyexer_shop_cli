require 'io/console'
require "./product_kart.rb"

shoploop = "s"
total=0
saved_total=0

# // 02/26/2021 19:41:11 Dragus Aexandru :-  an abstraction to make it work also as a discount price returner 
def  getfinalprice(price, quantity=0, discount_name = "")

    $discounts_arr.each {
        |discount_prop| 
        if discount_prop.type_name == discount_name 
            if quantity == 0
                @finalprice = (price - price * discount_prop.discount)
                return {"price" => @finalprice}
            end
            if quantity / discount_prop.quantity_condition >= 1
                if discount_prop.discount > 0
                    @finalprice = (price - price * discount_prop.discount) * quantity
                    @saved =  (price * discount_prop.discount) * quantity
                else
                    @freequantity=0
                    @temp_quantity = quantity
                    while @temp_quantity - discount_prop.quantity_condition >= 1
                        @temp_quantity -=  discount_prop.quantity_condition
                        @freequantity +=  discount_prop.quantity_bonus
                        @temp_quantity -= discount_prop.quantity_bonus
                    end
                    @saved = price * @freequantity
                    @finalprice = price * (quantity - @freequantity)
                end
            else 
            # puts "\nNo discount_prop." lol when replaced dscount. wih discount_prop.
            puts "\nNo discount."
            @finalprice = price * quantity
            @saved = 0
            end
            return {"price" => @finalprice, "saved" => @saved}
        end
    }
end



def buyf(product_nr=0)
    if product_nr==0
        product_nr=gets
    end
    if product_nr.match(/\A\d+\Z/) && Integer(product_nr) != 0
        if Integer(product_nr) <= $shop_products_arr.count 
            puts "Enter desired quantity for -| #{$shop_products_arr[Integer(product_nr)-1]["name"].upcase} |-, having the -| #{$shop_products_arr[Integer(product_nr)-1]["discount"]} |- discount, and confirm by pressing Enter:"
            product_quantity=gets
            if product_quantity.match(/\A\d+\Z/) && Integer(product_quantity.strip) != 0
                getpriceresult= getfinalprice($shop_products_arr[Integer(product_nr)-1]["price"], Integer(product_quantity.strip), $shop_products_arr[Integer(product_nr)-1]["discount"])
                $receipt_arr << $shop_products_arr[Integer(product_nr)-1].merge({"quantity" => product_quantity, "final_price" => getpriceresult["price"],  "saved" => getpriceresult["saved"]})
                
                puts "\n\nYou bought: "
                $receipt_arr.last.each {|key, value| print "#{key}: #{value}   "}
                puts

            else
            puts "\nEnter a non 0 number for the quantity.\n\n"
        end 
    else
        puts "\nEnter a number within the product range.\n\n"
    end 
    else 
    puts "\nEnter a non 0 number for the product.\n\n"
    end
end

def display_f(arr_of_hashes)
    puts
    @i=1

    if !arr_of_hashes.last["saved"].nil?
        total = 0
        saved_total = 0
    end

    arr_of_hashes.each { 
                |prod| 
                print "#{@i}. "
                prod.each {
                    |key, value| print "#{key}: #{value}   "
                          }
                if !prod["saved"].nil?
                    total += prod["final_price"]
                    saved_total += prod["saved"]
                end        
                
                @i+=1
                print "\n"
                       }

    if !arr_of_hashes.last["saved"].nil?
        puts "\ntotal:  #{total}   saved total:  #{saved_total} \n"
    end 
    
end


# until (shoploop == "l")
until (shoploop == "Leave sequance initiated. Prepare to launch to hyperspace")

    case shoploop  

        when /\A\d+\Z/
            buyf(shoploop)
            display_f($shop_products_arr)

        when "b"
            display_f($shop_products_arr)
            puts "Enter your choise (product number) and confirm by pressing Enter."
            buyf()

        when "s"  
            display_f($shop_products_arr)
            
        when "r"
            puts "Receipt: \n"
            display_f($receipt_arr)
            # puts "\ntotal:  #{total}   saved total:  #{saved_total} \n"
            puts "Thank you for shopping !  Please come again !"

        when "l"
            puts "\nThank you !  Please come again !"
            # // 02/26/2021 21:27:36 Dragus Aexandru :-  wasn't rimting msg please come again, was exiting straight away
            shoploop ="Leave sequance initiated. Prepare to launch to hyperspace"
            break

        else 
            puts "Choise did not match any option.\n\n"    
            display_f($shop_products_arr)

    end

    puts "\nEnter your choise (Product Number) and cofirm by pressing Enter."
    puts "Menu: Shop / Buy / Receipt  Check Out / Leave   (s/b/r/l)."
    shoploop = gets.downcase.strip!
end