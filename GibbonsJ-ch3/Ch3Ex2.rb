print "What was the odometer at when your tank was full:"
full = gets.chomp().to_i
print "What was the odometer at when your tank was empty:"
empty = gets.chomp().to_i
print "How many gallons of gas does your tank hold:"
gallons = gets.chomp().to_i

delta = empty - full
mpg = delta / gallons

puts "From mile " + full.to_s + " to mile " + empty.to_s + " you had an average mpg of " + mpg.to_s
