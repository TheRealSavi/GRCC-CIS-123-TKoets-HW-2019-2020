def ask
  puts ""
  print "How many hours did you work this week:"
  $hoursWorked = gets.chomp().to_f

  print "whats your hourly pay rate:"
  $rate = gets.chomp().to_f
  decide()
end

def decide
  if $hoursWorked == nil || $hoursWorked <= 0
    print "Hours worked must be greater than 0"
    ask()
    return
  end
  if $rate == nil || $rate <= 0
    print "pay rate must be greater than 0"
    ask()
    return
  end

  if $hoursWorked > 40.0
    $overtime = $hoursWorked - 40.0
    $overtimePay = $overtime * ($rate * 1.5)
  else
    $overtime = 0.0
    $overtimePay = 0.0
  end
  calculate()
end

def calculate
  $wage = $overtimePay + ($rate * $hoursWorked.clamp(0,40))

  puts "Because you worked " + ('%.2f' % $overtime).to_s + " hours of overtime"
  puts "You will be payed $" + ('%.2f' % $wage).to_s + " for this week"
  ask()
end

ask()
