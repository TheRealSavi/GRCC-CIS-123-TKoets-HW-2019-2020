temps = []

print "What is the average temperature for the month of November:"
temps.push(gets.chomp.to_f)
print "What is the average temperature for the month of December:"
temps.push(gets.chomp.to_f)
print "What is the average temperature for the month of January:"
temps.push(gets.chomp.to_f)
print "What is the average temperature for the month of February:"
temps.push(gets.chomp.to_f)

avg = temps.sum / temps.count

puts "Average temperature between November and February is " + avg.to_s
