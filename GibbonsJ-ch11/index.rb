require_relative 'src/User.rb'
require_relative 'src/Test.rb'
require_relative 'src/Question.rb'

def clearScreen()
  sleep(0.75)
  #attempts to call clear for terminal, if it fails, attempts to call cls for windows command line
  system("clear") || system("cls")
end

def mainMenu()
  clearScreen()
  puts ""
  puts "(0) Make a new user or (1) Login to a user"
  print "Action: "
  action = gets.chomp

  puts ""
  case action
  when "0"
    print "Username: "
    username = gets.chomp

    print "Password: "
    password = gets.chomp

    type = ""
    until type.downcase == "student" || type.downcase == "admin"
    puts "Account Type: "
    print "admin or student: "
    type = gets.chomp
    end

    status = User.newUser(username, password, type)
    if status == false
      puts ""
      puts "Couldnt make that user"
      puts ""
    else
      puts ""
      puts "User created"
      puts ""
    end
    mainMenu()
  when "1"
    print "Username: "
    username = gets.chomp

    print "Password: "
    password = gets.chomp

    user = User.new(username, password)
    status = user.login()

    if status == false
      puts ""
      puts "Wrong user info"
      mainMenu()
    else
      puts ""
      puts "Logged into: " + user.username
      dashboard(user)
    end
  else
    mainMenu()
  end
end

def dashboard(user)
  clearScreen()
  puts ""
  puts "Welcome to the " + user.type + " dashboard!"
  case user.type
  when "admin"
    puts "(0) New Test or (1) View Test or (2) Logout"
    print "Action: "
    action = gets.chomp
    case action
    when "0"
      Test.newTest()
    when "1"
      test = Test.picker()
      test.view()
    when "2"
      user.logout()
      mainMenu()
    end
  when "student"
    puts "(0) Take a test or (1) View test Scores or (2) Logout"
    print "Action: "
    action = gets.chomp
    case action
    when "0"
      test = Test.picker()
      user.takeTest(test)
    when "1"
      test = Test.picker()
      user.viewScore(test)
    when "2"
      user.logout()
      mainMenu()
    end
  end
  dashboard(user)
end

mainMenu()
