require 'io/console'
require "./Shop__Classes_Arrays.rb"


shoploop = "s"
total=0
saved_total=0


def buyf(prodnr=0)
    if prodnr==0
        prodnr=gets
    end
    if prodnr.match /\A\d+\Z/
        if Integer(prodnr) <= $produkts_arr.count
            puts "Enter desired quantity for -| #{$produkts_arr[Integer(prodnr)-1].name.upcase} |- and confirm by pressing Enter:"
            prodq=gets
            if prodq.match(/\A\d+\Z/)
                puts "\n\nYou bought: "
                $produkts_b_arr << Produkt_Bought.new($produkts_arr[Integer(prodnr)-1].name, $produkts_arr[Integer(prodnr)-1].price, $produkts_arr[Integer(prodnr)-1].discnr, prodq.strip!)
                print "produkt: #{$produkts_b_arr.last.name}   baseprice: #{$produkts_b_arr.last.price}     discount : #{$disctext[$produkts_b_arr.last.discnr]}  quantity: #{$produkts_b_arr.last.price_saved[2]} final price: #{$produkts_b_arr.last.price_saved[0]}  saved: #{$produkts_b_arr.last.price_saved[1]}\n\n\n"

                #2021.02.05 10,51 creaes err when presing enter needs to press enter twice and this ads a char for the next input like CR and it doesent match any option triggered falsely and code executes normally
                # puts "Press any Key to continue.\n\n"
                # STDIN.getch
                # print "            \r"

            else
            puts "\nEnter a number for the quantity.\n\n"
        end 
    else
        puts "\nEnter a number within the produkt range.\n\n"
    end 
    else 
    puts "\nEnter a number for the produkt.\n\n"
    end
end


until (shoploop == "l")

    case shoploop  

        when "l"
        puts "\nThank you !  Please come again !"
    
        when "r"
            puts "\nReceipt: "
            ii=1
            $produkts_b_arr.each {
                |x| 
                print "#{ii}. produkt: #{x.name}   baseprice: #{x.price}     discount : #{$disctext[x.discnr]}  quantity: #{x.pquan} final price: #{x.price_saved[0]}  saved: #{x.price_saved[1]}\n"
                total +=x.price
                saved_total +=x.price_saved[1]
                ii=ii+1
                                 }

            puts "total:  #{total}   saved total:  #{saved_total} \n"
            puts "Thank you for shopping !  Please come again !"

        when "s"  
            puts 
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.price}     discount number: #{x.discnr} \n"
                i=i+1
                               }

        when "b"
            puts
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.price}     discount number: #{x.discnr}\n"
                i=i+1
                            }
            puts "Enter your choise (produkt number) and confirm by pressing Enter."

            buyf()
            
        when /\A\d+\Z/
            buyf(shoploop)
            puts 
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.price}     discount number: #{x.discnr} \n"
                i=i+1
                               }
        else 
            puts "\nChiose did not match any option.\n\n"    
            i=1
            $produkts_arr.each {
                |x| print "#{i}. produkt: #{x.name}   baseprice: #{x.price}     discount number: #{x.discnr} \n"
                i=i+1
                               }                       
    end

    puts "\nEnter your choise (Produkt Number) and cofirm by pressing Enter."
    puts "Menu: Shop / Buy / Receipt  Check Out / Leave   (s/b/r/l)."
    shoploop = gets.downcase.strip!
end
