require "./Produkt.rb"

shoploop = "s"
total=0
saved_total=0


#2021.1.18 21,23 perhaps another row with quantity impacted to distinguis price impact or q impact ... more err rezil and scal
$discquan = 
[
    # discount, quantity bonus, quantity condition
    [0,0,1], #avoid div by 0
    [0,1,1], #Buy One Get One Free
    [0,1,2], #Buy Two Get One Free
    [0.5,0,5], #Buy 5 To Get 50% off
    [0.1,0,1], #10% off
    [0.25,0,1] #25% off
]

$receipt_arr= Array.new 
$produkts_arr= Array.new


#the name is lost when added to the arr so a name param is needed
bread = Produkt.new("bread",10,5)
$produkts_arr << bread
orange = Produkt.new("orange",8,1)
$produkts_arr << orange
cola = Produkt.new("cola",3,2)
$produkts_arr << cola
cocoa = Produkt.new("cocoa",12,3)
$produkts_arr << cocoa


def  getfinprice(baseprice, quantity, discnr = 0)
    price_saved = Array.new 
    if quantity / $discquan[discnr][2] >= 1
        if $discquan[discnr][0] > 0
          finalprice = (baseprice - baseprice * $discquan[discnr][0]) * quantity
          saved =  baseprice * quantity - finalprice
        else
        # not like you buy 100 ORANGES AND THE CASHIER SAYS BUY ONE GET ONE FREE NOW U HAVE 200 ORANGES ...
             freeq=0
             opquantity = quantity
            while opquantity - $discquan[discnr][2] >= 1
                opquantity -= $discquan[discnr][2]
                freeq+= $discquan[discnr][1]
                opquantity -= $discquan[discnr][1]
            end
            saved = baseprice * freeq
            finalprice = baseprice * (quantity - freeq)
        end
    else 
        puts "\nNo discount."
        finalprice = baseprice * quantity
        saved = 0
    end
    #replace with obj instead of arr
    return price_saved << finalprice << saved << quantity
end


def buyf(prodnr=0)
    if prodnr==0
        prodnr=gets
    end
    if prodnr.match /\d+/
        puts "Enter desired quantity:"
        prodq=gets
        if Integer(prodnr) <= $produkts_arr.count
            if prodq.match(/\d+/)
            fprice = getfinprice($produkts_arr[Integer(prodnr)-1].baseprice, Integer(prodq), $produkts_arr[Integer(prodnr)-1].discnr)
            puts "You bought: "
            print "produkt: #{$produkts_arr[Integer(prodnr)-1].name}   baseprice: #{$produkts_arr[Integer(prodnr)-1].baseprice}     discount number: #{$produkts_arr[Integer(prodnr)-1].discnr}  quantity: #{Integer(fprice[2])} final price: #{fprice[0]}  saved: #{fprice[1]}\n\n\n"
            $receipt_arr << [$produkts_arr[Integer(prodnr)-1].name, $produkts_arr[Integer(prodnr)-1].baseprice, $produkts_arr[Integer(prodnr)-1].discnr, fprice[2], fprice[0], fprice[1]]
            else
            puts "Enter a number please."
            end 
        else
            puts "\nEnter a number within the produkt range"
        end 
    else 
        puts "Enter a number please."
    end
end



#until (shoploop == "r" || shoploop == "l")
until (shoploop == "l")


    case shoploop
   

        when "l"
        puts "\nThank you !  Please come again !"
    
        when "r"
            puts "\nReceipt: "
            ii=1
            $receipt_arr.each {
                |x| print "#{ii}. produkt: #{x[0]}   baseprice: #{x[1]}     discount number: #{x[2]}  quantity: #{x[3]} final price: #{x[4]}  saved: #{x[5]} \n"
                total +=x[4]
                saved_total +=x[5]
                ii=ii+1
                            }
            print "total:  #{total}   saved total:  #{saved_total} \n"
            puts "Thank you for shopping !  Please come again !"


        when "s"  
            puts 
            i=1
            $produkts_arr.each {

                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.baseprice}     discount number: #{x.discnr} \n"
                i=i+1
                            }


        when "b"
            puts
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.baseprice}     discount number: #{x.discnr}\n"
                i=i+1
                            }
            puts "Enter your choise (produkt number)"

            buyf()
            

        when /\d+/
            buyf(shoploop)
    end

    puts "\nEnter your choise (produkt number)."
    puts "Menu: Shop / Buy / Receipt  Check Out / Leave   (s/b/r/l)."
    shoploop = gets.downcase.strip!

end