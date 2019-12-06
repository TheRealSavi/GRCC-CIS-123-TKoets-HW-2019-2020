class User
  attr_reader :username, :type, :isLoggedIn
  def initialize(username, password)
    @username = username
    @password = password
    @type = nil
    @isLoggedIn = false
  end

  def self.newUser(username, password, type)
    begin
    Dir.mkdir('Users/' + username)
    Dir.mkdir('Users/' + username + "/Scores/")
    userfile = File.new('Users/' + username + '/' + username + '.szi', 'w+')
    userfile.print(username + '-' + password + '-' + type)
    userfile.close
    return true
    rescue
      return false
    end
  end

  def login()
    puts ""
    begin
      userfile = File.open('Users/' + @username + '/' + @username + '.szi', 'r')
    rescue
      return false
    end
    userinfo = userfile.read
    userfile.close()
    userinfo = userinfo.split('-')

    if userinfo[1] == @password
      @type = userinfo[2].chomp
      @isLoggedIn = true
      return true
    else
      return false
    end
  end

  def logout()
    puts ""
    puts "Logged out of user: " + @username
    @isLoggedIn = false
    @type = nil
    @password = nil
  end

  def takeTest(test)
    clearScreen()
    puts ""
    if @isLoggedIn == false
      puts "Error: User is not logged in, can not take test"
      return
    end

    puts "Taking test: " + test.name
    puts ""

    score = 0
    test.questions.each do |question|
      clearScreen()
      puts ""
      puts question.question

      case question.type

      when "TF"
        puts "(T) True or (F) False?"
        print "Answer: "
        choice = gets.chomp.downcase
        until choice == "t" || choice == "f"
          puts "must be t or f"
          print "Answer: "
          choice = gets.chomp.downcase
        end

      when "MC"
        letter = "A"
        question.options.each do |option|
          print letter + ": "
          puts option.strip.strip
          letter = letter.succ
        end
        print "Answer: "
        choice = gets.chop.downcase
        until choice == "a" || choice == "b" || choice == "c" || choice == "d"
          puts "must be a, b, c, or d"
          print "Answer: "
          choice = gets.chop.downcase
        end

      when "FB"
        puts "Please fill in the blank. "
        for i in question.answer.split("")
          if i == "" || i == " "
            print " "
            next
          else
            print "_"
          end
        end
        puts ""
        puts "The blank is " + (question.answer.length).to_s + " characters long"
        print "Answer: "
        choice = gets.chomp.downcase
      end

      if choice == question.answer.downcase
        puts ""
        puts "   Correct   "
        score += 1
      else
        puts ""
        puts "   Incorrect   "
      end

    end

    clearScreen()
    puts ""
    puts "Final score is " + score.to_s + "/" + test.questions.count.to_s
    percentage = ((score.to_f/test.questions.count.to_f) * 100).round(2)
    puts percentage.to_s + "%, Nice!"

    scorefile = File.new('Users/' + @username + "/scores/" + test.name.to_s + ".szi", 'w+')
    scorefile.puts "Your final score was " +  percentage.to_s + "%, Good job!"
    scorefile.close

    puts ""
    puts "Press return to continue..."
    gets

  end

  def viewScore(test)
    clearScreen()
    puts ""
    if @isLoggedIn == false
      puts "Error: User is not logged in, can not view scores"
      return
    end

    puts "Viewing score for test: " + test.name
    begin
      score = File.read('Users/' + @username + '/scores/' + test.name + '.szi')
      puts score
    rescue
      puts "No score for this test yet."
    end
    puts ""
    puts "Press return to continue..."
    gets
  end

end
