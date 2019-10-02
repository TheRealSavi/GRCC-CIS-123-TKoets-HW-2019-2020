=begin
Chapter 5 assignment
2 Player Nim
John Gibbons
10/2/19
Tim Koets
Nim, the game of taking sticks from piles, your only goal is to make your opponent take the last stick
=end

#gets player1's name
print "Player1, please enter your name:"
$p1name = gets.chomp

#gets player2's name
print "Player2, please enter your name:"
$p2name = gets.chomp

#I modified the boolean classes to have a to_name function so that i can easily toggle names by inverting a boolean
class TrueClass
  def to_name
    return $p1name
  end
end
class FalseClass
  def to_name
    return $p2name
  end
end
#defaults the global name variable to true, this means that the first turn will be taken by player1
$name = true

#I made a class for the piles that has the count of how many sticks are in it and a take function to easily update that
class Pile
  attr_accessor :count
  def initialize(count)
    @count = count
  end

  def take(amount)
    @count -= amount
  end
end

#I make the global piles array and add 3 piles to it, each with 1 more stick than the last, starting at 3 sticks
$piles = []
3.times { |i| $piles.push(Pile.new(i+3)) }

#I made a showPiles function to easily refer to later that loops through all the piles and shows their count of sticks
def showPiles
  3.times { |i| puts i.to_s + " : " + $piles[i].count().to_s}
end

#I made a turn function that gets called every time a turn needs to be made
def turn
  #I always start a turn by show the player the latest values of all the piles by calling my showPiles function
  showPiles()

  #Here i set some out-of-bounds defaults so that the until statements start false, allowing the player to make their choice
  take = -1
  pile = -1
  sum  = 0

  #at the start of the turn I check if the sum of the sticks in all the piles is 0 or less, indicating that there are no more moves to make and this player has won
  $piles.each do |i|
      sum += i.count
  end
  if sum <= 0
    puts $name.to_name + ", You win!!"
    return #this return is to exit the turn function returning to the rest of the code which is empty, essentially stopping the game now that it has been determined to be won and over.
  end

  #this ensures that the pile chosen is a valid number,because until it is it wont stop asking
  until pile.between?(0,2)
    print $name.to_name + ", Choose a pile:"
    pile = gets.chomp().to_i
  end

  #this ensures that the pile chosen isnt already empty by restarting the turn if the chosen piles count is 0 or less
  if $piles[pile].count <= 0
    puts "That pile is already empty, try again"
    turn()
    return
  end

  #this ensures that the pile chosen has enough sticks in it to complete the users move of taking their defined sticks.
  until take.between?(1,$piles[pile].count)
    print "How many to remove from pile " + pile.to_s + ":"
    take = gets.chomp().to_i
  end

  #this will only be ran once everything above it has been determined the move to be a plausible move, and calls the take function for the users decided sticks from their decided pile
  $piles[pile].take(take)

  #this inverts the name boolean so that it will show the next players name on the next turn
  $name = !$name
  #this begins the next players turn by calling the turn function, now that this players turn is done
  turn()
end

#this gets the game started by starting the first turn of the game
turn()
