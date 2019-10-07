$winners = []
$data = []
$games = 0

puts "say 'done' when finished entering"
puts ""

while true do
  print "who was the wining team: "
  input = gets.chomp
  break if input == 'done'
  $winners.push(input)
  $games += 1
end

$winners.uniq.each do |i|
  $data.push(
    [i,
    $winners.count(i),
    ($winners.count(i).to_f / $games.to_f)
    ]
  )
end

puts ""
puts "Now sorting alphabeticaly"
puts ""

$data.sort! {|x,y| x[0] <=> y[0]}
$data.each do |i|
  puts "team " + i[0].to_s + " won " + i[1].to_s + " games. That means their rank is " + i[2].to_s
end

puts ""
puts "Now sorting by highest rank"
puts ""

$data.sort! {|x,y| x[2] <=> y[2]}
$data.reverse!
$data.each do |i|
puts "team " + i[0].to_s + " won " + i[1].to_s + " games. That means their rank is " + i[2].to_s
end
