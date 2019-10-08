=begin
Chapter 6 assignment
John Gibbons
10/6/19
Tim Koets
This program takes a list of the winners for all the games in a season and sorts them for you
=end

$winners = [] #initializes the array that holds the users input
$data = []    #initializes the array that holds the formatted data from the winners array

puts "say 'done' when finished entering"
puts ""

while true do #loops forever
  print "who was the winning team of game " + ($winners.length+1).to_s + " : "
  input = gets.chomp
  break if input == 'done' #exits the loop if the user inputs done
  $winners.push(input)
end

$winners.uniq.each do |i|  #for all the unique entries of the users input to the winners array
  $data.push(              #add an array to the data array that contains the information about what the user entered for that team
    [i,                                         #this is simply the teams name
    $winners.count(i),                          #this is how many times the teams name appears in the winners array
    ($winners.count(i).to_f / $winners.length)  #this is how many times the teams name appears in the winners array divided by the total ammount of games entered, so it gives the teams "rank"
    ]
  )
end

puts ""
puts "Now sorting alphabeticaly"
puts ""

$data.sort_by! {|obj| obj[0]} #this rearranges the array based on the elements 0th position. since this position stores the name its alphabeticaly sorted.
$data.each do |i|                 #for all the items in the data array it will show all the information about that team
  puts "team " + i[0].to_s + " won " + i[1].to_s + " games. That means their rank is " + i[2].to_s
end

puts ""
puts "Now sorting by highest rank"
puts ""

$data.sort_by! {|obj| obj[2]} #this rearranges the array based on the elements 2nd position. since this position stores the teams "rank" it is sorted by rank
$data.reverse!                    #by default it sorts least to greatest but we want gretest to least so i just reverse the array.
$data.each do |i|                 #for all the items in the data array it will show all the information about that team
puts "team " + i[0].to_s + " won " + i[1].to_s + " games. That means their rank is " + i[2].to_s
end

=begin
Expected output :
  say 'done' when finished entering

  who was the winning team of game 1 : Lions
  who was the winning team of game 2 : Bears
  who was the winning team of game 3 : Lions
  who was the winning team of game 4 : Cubs
  who was the winning team of game 5 : Cubs
  who was the winning team of game 6 : Bears
  who was the winning team of game 7 : Lions
  who was the winning team of game 8 : Lions
  who was the winning team of game 9 : Leafs
  who was the winning team of game 10 : done

  Now sorting alphabeticaly

  team Bears won 2 games. That means their rank is 0.2222222222222222
  team Cubs won 2 games. That means their rank is 0.2222222222222222
  team Leafs won 1 games. That means their rank is 0.1111111111111111
  team Lions won 4 games. That means their rank is 0.4444444444444444

  Now sorting by highest rank

  team Lions won 4 games. That means their rank is 0.4444444444444444
  team Cubs won 2 games. That means their rank is 0.2222222222222222
  team Bears won 2 games. That means their rank is 0.2222222222222222
  team Leafs won 1 games. That means their rank is 0.1111111111111111
=end
