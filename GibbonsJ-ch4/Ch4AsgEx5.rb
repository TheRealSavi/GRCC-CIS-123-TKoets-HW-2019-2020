def askView
  puts ""
  print "What is in view? (park, golf course, or lake):"
  $view = gets.chomp().downcase
  checkView()
end
def checkView
  if $view != "park" && $view != "golf course" && $view != "lake"
    puts "Enter a valid location in view"
    askView()
    return
  else
    askPark()
  end
end

def askPark
  puts ""
  print "How do you want to park? (lot, awning, garage):"
  $park = gets.chomp().downcase
  checkPark()
end
def checkPark
  if $park != "lot" && $park != "awning" && $park != "garage"
    puts "Enter a valid parking method"
    askPark()
    return
  else
    calculate()
  end
end

CostOf = {
  "park"        => 150000,
  "golf course" => 170000,
  "lake"        => 210000,

  "lot"    => 0,
  "awning" => 3000,
  "garage" => 6000
}

def calculate
  $price = CostOf[$view] + CostOf[$park]
  puts ""
  puts "Becasue you chose " + $view + " as your view, that will cost $"              + ('%.2f' % CostOf[$view]).to_s
  puts "Becasue you chose " + $park + " as your method of parking, that will cost $" + ('%.2f' % CostOf[$park]).to_s
  puts ""
  puts "Your grand total will be $" + ('%.2f' % $price).to_s
  askView()
end

askView()
