print "What is your height in inches:"
inches = gets.chomp().to_f
print "What is your weight in pounds:"
pounds = gets.chomp().to_f

cm = inches * 2.54
m = cm * 100

g = pounds * 453.59
kg = g * 1000

bmi = kg / m ** 2

puts "Your bmi is " + bmi.to_s
