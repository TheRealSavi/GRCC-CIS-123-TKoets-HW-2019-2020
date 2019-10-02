def ask
  puts ""
  print "Whats the speed limit:"
  $speedLim = gets.chomp().to_i

  print "How fast was the driver going:"
  $speed = gets.chomp().to_i
  decide()
end

def decide
  if $speedLim == nil || $speedLim <= 0
    puts "Speed Limit must be at least 1"
    ask()
    return
  end
  if $speed == nil || $speed < 0
    puts "Drivers speed must be at least 0"
    ask()
    return
  end

  $ticket = 0
  if $speed > $speedLim
    $ticket = 50 + ($speed-$speedLim) * 5
  end
  if $speed > 90
    $ticket += 200
  end

  if $ticket > 0
    puts "The driver owes $" + ('%.2f' % $ticket).to_s
  else
    puts "No ticket should be issued"
  end
  ask()
end

ask()
