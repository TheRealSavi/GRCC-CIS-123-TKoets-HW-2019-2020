class Player
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = []
  end

  def addCard(card)
    @hand.push(card)
  end

  def showCards()
    puts @name.to_s + "'s Hand"
    @hand.each do |card|
      puts card
    end
  end

  def match()
    removes = @hand.select{ |e| @hand.count(e) > 1 }
    puts "found matches: " + removes.to_s
    @hand = @hand - removes
  end

  def take()
    if @hand.count >= 1
      cardIndex = rand(@hand.count)
      card = @hand[cardIndex]
      @hand.delete_at(cardIndex)
      return card
    else
      return "0"
    end
  end
end

class Card
  def self.deal(allPlayers)
    deck = ["1","1","2","2","3","3","4","4","5","5","6","6","7","7","8","8","9","9","10","10","oldMaid"]
    until deck.count < 1
      allPlayers.each do |player|
        top = deck.count - 1
        if top == -1
          break
        end
        cardIndex = Random.rand(0..top)
        card = deck[cardIndex]
        deck.delete_at(cardIndex)
        player.addCard(card)
      end
    end
  end
end

def game()
  allPlayers = []

  puts "How many players are there?"
  players = ""
  until players.to_i > 1 && players.to_i <= 5
    puts "Must be more than 1 and no more than 5"
    print "Players: "
    players = gets.chomp
  end

  players.to_i.times do |i|
    puts ""
    puts "Player " + (i + 1).to_s + ", what is your name?"
    print "name: "
    name = gets.chomp
    allPlayers.push(Player.new(name))
  end

  Card.deal(allPlayers)

  puts ""
  puts "All players hands:"
  allPlayers.each do |player|
    player.showCards()
  end

  puts ""
  puts "Inital match:"
  allPlayers.each do |player|
    player.match()
    player.showCards()
  end

  #Actual game loop
  currentPlayer = -1
  loop do
    max = -1
    allPlayers.each do |player|
      if player.hand.count > max
        max = player.hand.count
      end
    end
    if max == 1
      break
    end

    currentPlayer += 1
    if currentPlayer > allPlayers.length - 1
      currentPlayer = 0
    end
    puts ""
    puts "It's " + allPlayers[currentPlayer].name + "'s turn!"

    nextPlayer = currentPlayer + 1
    if nextPlayer > allPlayers.length - 1
      nextPlayer = 0
    end

    thiscard = allPlayers[nextPlayer].take

    until thiscard != "0"
      nextPlayer = nextPlayer + 1
      if nextPlayer > allPlayers.length - 1
        nextPlayer = 0
      end
      thiscard = allPlayers[nextPlayer].take
    end

    allPlayers[currentPlayer].addCard(thiscard)

    puts ""
    puts "Taking " + allPlayers[nextPlayer].name + "'s card: " + thiscard.to_s

    allPlayers[currentPlayer].match

    allPlayers.each do |player|
      player.showCards()
    end

  end

  puts ""
  allPlayers.each do |player|
    if player.hand.include?("oldMaid")
      puts player.name + " is the loser"
    end
  end

end

game()
