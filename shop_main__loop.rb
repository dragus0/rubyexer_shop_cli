require "./Produkt.rb"

shoploop = "s"
total=0
saved_total=0


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

$disctext = Hash[
    0 => "No discount",
    1 => "Buy One get One free",
    2 => "Buy Two get One Free",
    3 => "Buy Five to get 50% Off",
    4 => "10% Off",
    5 => "25% Off"
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
    return price_saved << finalprice << saved << quantity
end


def buyf(prodnr=0)
    if prodnr==0
        prodnr=gets
    end
    if prodnr.match /\A\d+\Z/
        puts "Enter desired quantity:"
        prodq=gets
        if Integer(prodnr) <= $produkts_arr.count && Integer(prodnr) > 0
            if prodq.match(/\A\d+\Z/) && Integer(prodq) > 0
                fprice = getfinprice($produkts_arr[Integer(prodnr)-1].baseprice, Integer(prodq), $produkts_arr[Integer(prodnr)-1].discnr)
                puts "You bought: "
                print "produkt: #{$produkts_arr[Integer(prodnr)-1].name}   baseprice: #{$produkts_arr[Integer(prodnr)-1].baseprice}     discount number: #{$produkts_arr[Integer(prodnr)-1].discnr}  quantity: #{Integer(fprice[2])} final price: #{fprice[0]}  saved: #{fprice[1]}\n\n\n"
                $receipt_arr << [$produkts_arr[Integer(prodnr)-1].name, $produkts_arr[Integer(prodnr)-1].baseprice, $produkts_arr[Integer(prodnr)-1].discnr, fprice[2], fprice[0], fprice[1]]
            else
            puts "\nEnter a Number for the desired quantity please."
            end 
        else
            puts "\nEnter a Number within the Produkt range please"
        end 
    else 
        puts "Enter a Number for the desired Produkt please."
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
                |x| print "#{ii}. produkt: #{x[0]}   baseprice: #{x[1]}     discount: #{$disctext[x[2]]}  quantity: #{x[3]} final price: #{x[4]}  saved: #{x[5]} \n"
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
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.baseprice}     discount: #{$disctext[x.discnr]} \n"
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

        when /\A\d+\Z/
            # https://medium.com/launch-school/number-validation-with-regex-ruby-393954e46797
            # obj = obj.to_s unless obj.is_a? String
            buyf(shoploop)

            puts 
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.baseprice}     discount: #{$disctext[x.discnr]} \n"
                i=i+1
                               }
    end

    puts "\nEnter your choise (produkt number)."
    puts "Menu: Shop / Buy / Receipt  Check Out / Leave   (s/b/r/l)."
    shoploop = gets.downcase.strip!

end
