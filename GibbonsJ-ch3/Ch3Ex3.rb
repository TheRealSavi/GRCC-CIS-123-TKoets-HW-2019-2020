print "What is the length in feet of your house:"
houseLen = gets.chomp().to_i
print "What is the width in feet of your house:"
houseWid = gets.chomp().to_i

print "What is the length in feet of your driveway:"
driveLen = gets.chomp().to_i
print "What is the width in feet of your driveway:"
driveWid = gets.chomp().to_i

print "What is the length in feet of your yard:"
yardLen = gets.chomp().to_i
print "What is the width in feet of your yard:"
yardWid = gets.chomp().to_i

print "What is the cost per bag of fertalizer:"
costBag = gets.chomp().to_f
print "What is the square feet per bag of fertalizer:"
sqftBag = gets.chomp().to_i

houseArea = houseLen * houseWid
driveArea = driveLen * driveWid
yardArea  = yardLen  *  yardWid

fertArea = yardArea - driveArea - houseArea
bagCount = fertArea / sqftBag
fertCost = costBag * bagCount

puts "It will cost $" + fertCost.to_s + " to fertalize your yard"
