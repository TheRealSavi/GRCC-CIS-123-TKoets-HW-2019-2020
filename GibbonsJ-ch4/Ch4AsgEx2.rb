def ask
  puts ""
  print "How many books will you be purchasing:"
  $books = gets.chomp().to_f

  print "How much does the book cost:"
  $cost = gets.chomp().to_f
  decide()
end

def decide
  if $cost == nil || $cost < 0.01
    puts "Use a valid number for the price (0.01 and up)"
    ask()
    return
  else
    if (1..9) === $books
      $discount = 0
      puts ""
      puts "No discount available for this quanity"
    elsif (10..19) === $books
      $discount = 0.20
    elsif (20..49) === $books
      $discount = 0.30
    elsif (50..99) === $books
      $discount = 0.40
    elsif $books >= 100
      $discount = 0.50
    else
      puts "Use a valid number for the number of books (1 and up)"
      ask()
      return
    end
  end
  calculate()
end

def calculate
  if $discount > 0
    puts ""
    puts "The discount is " + ($discount * 100.0).to_s + "% off!"
    puts "If the discount was not used it would cost $" + ('%.2f' % ($books * $cost)).to_s
    puts "The cost after the discount is $" + ('%.2f' % ((1-$discount) * $cost * $books)).to_s
    puts "Due to the discount you have saved $" + ('%.2f' % ($discount * $cost * $books)).to_s
  else
    puts ""
    puts "Your total cost will be $" + ('%.2f' % ($cost * $books)).to_s
  end
  ask()
end

ask()
