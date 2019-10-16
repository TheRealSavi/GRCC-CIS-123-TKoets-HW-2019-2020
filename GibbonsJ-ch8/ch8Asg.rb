$Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
$cost = nil
$costBefore = {}
$costAfter = {}
$saved = {}

puts ""
until $cost.to_i.to_s == $cost && $cost.to_i > 0
  print "How much did it cost to install the new sinks:"
  $cost = gets.chomp
end

puts ""
puts "How much did it cost per month BEFORE installing the sinks"
$Months.each do |month|
  until $costBefore[month].to_i.to_s == $costBefore[month]
    print "How much did it cost for the month of " + month + ":"
    $costBefore[month] = gets.chomp
  end
end

puts ""
puts "How much did it cost per month AFTER installing the sinks"
$Months.each do |month|
  until $costAfter[month].to_i.to_s == $costAfter[month]
    print "How much did it cost for the month of " + month + ":"
    $costAfter[month] = gets.chomp
  end
end

puts ""
puts "Here is how much you saved per month"
$Months.each do |month|
  $saved[month] = $costBefore[month].to_i - $costAfter[month].to_i
  puts month + ": " + $saved[month].to_s
end

puts ""
puts "Here is how much you saved per month sorted by greatest savings"
$saved.sort_by {|month, amount| amount}.reverse.each do |month, amount|
  puts month + ": " + amount.to_s
end

puts ""
puts "total saved in a year is: " + $saved.values.sum.to_s

puts ""
puts "It will take " + ($cost.to_i/$saved.values.sum).to_s + " years for the sinks to pay for themselves"
