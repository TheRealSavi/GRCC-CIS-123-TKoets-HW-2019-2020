def ask
  puts ""
  print "Enter weight of package:"
  $weight = gets.chomp().to_f
  decide()
end

def decide
  if $weight == 1
    $perPound = 1.10
  elsif (2..6) === $weight
    $perPound = 2.20
  elsif (7..10) === $weight
    $perPound = 3.70
  elsif $weight > 10
    $perPound = 3.80
  else
    puts "Use a valid number (1 and up)"
    ask()
    return
  end
  calculate()
end

def calculate
  totalCost = $perPound * $weight
  puts "The cost per pound will be $" + ('%.2f' % $perPound).to_s
  puts "The shipping will cost $" + ('%.2f' % totalCost).to_s
  ask()
end

ask()
