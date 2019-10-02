print "How much was the meal:"
meal = gets.chomp().to_f
print "What percentage do you want to tip (0.00 to 1.00) ex;(0.20):"
tipPercent = gets.chomp().to_f

puts "Cost of tip at " + (tipPercent * 100).to_s + "% is $" + (meal * tipPercent).to_s
puts "Your total cost comes out to $" + (meal + (meal * tipPercent)).to_s
