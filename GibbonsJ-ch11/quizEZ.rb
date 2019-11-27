TestQuestion = Struct.new(:question, :type, :options, :answer)

class App
  attr_accessor :isLoggedIn
  def initialize(args = {})
    puts ""
    puts "   ~~~   New App Created   ~~~   "
    @user = nil
    @isLoggedIn = false
  end

  def login()
    puts ""
    puts "(0) login or (1) make a new user"
    option = gets.chomp()
    case option
    when "0"
      begin
      puts "whats the username"
      username = gets.chomp
      puts "whats the password"
      password = gets.chomp
      @user = User.login(username, password)
      rescue
        puts "That user doesn't exist, sorry"
        login()
        return
      end
    when "1"
      puts "whats the username"
      username = gets.chomp
      users = Dir.children("Users/")
      if users.include?(username)
        puts "That has been taken, please choose another"
        login()
        return
      end
      puts "whats the password"
      password = gets.chomp
      puts "what user type (admin or student)"
      type = ""
      until type == "student" || type == "admin"
        type = gets.chomp
      end
      @user = User.newUser(username, password, type)
    end
    if @user != nil
      @isLoggedIn = true
      return
    else
      @isLoggedIn = false
      return
    end
  end

  def start()
    puts ""
    until @isLoggedIn
      puts "   !!!   App not logged in   !!!   "
      login()
    end
    dashboard()
  end

  def dashboard()
    puts ""
    case @user.type
    when "student"
      puts "(0) Take a test or (1) View test Scores or (2) Logout"
      option = gets.chomp
      case option
      when "0"
        Test.takeTest(Test.parseTest(Test.pickTest(@user.name), @user.name))
      when "1"
        if Dir.children("Users/#{@user.name}/scores").count < 1
          puts "You have no scores"
        else
          Test.viewScores(@user.name)
        end
      when "2"
        logout()
        return
      end
    when "admin"
      puts "(0) New Test or (1) View Test or (2) Logout"
      option = gets.chomp
      case option
      when "0"
        Test.build(Test.newTest())
      when "1"
        if Dir.children("Tests/").count < 1
          puts "You have no tests"
        else
          Test.viewTest(Test.parseTest(Test.pickTest(@user.name), @user.name))
        end
      when "2"
        logout()
        return
      end
    else
      puts "   !!!   user type invalid   !!!   "
      logout()
      return
    end
    dashboard()
  end

  def logout()
    @user = nil
    @isLoggedIn = false
    start()
  end
end

class User
  puts ""
  attr_reader :name, :type
  def initialize(username,usertype)
    puts
    @name = username
    @type = usertype
  end

  def self.login(username, password)
    puts ""
    userfile = File.open('Users/' + username + '/' + username + '.szi', 'r')
    userinfo = userfile.read
    userfile.close()
    userinfo = userinfo.split('-')

    if userinfo[0] == username && userinfo[1] == password # read actual info from userfile
      puts "   ^^^   logged into " + userinfo[0] + "   ^^^   "
      return User.new(userinfo[0],userinfo[2])
    else
      puts "   !!!   incorrect login info  !!!   "
      return nil
    end
  end

  def self.newUser(username, password, usertype)
    puts ""
    Dir.mkdir('Users/' + username)
    Dir.mkdir('Users/' + username + "/Scores/")
    userfile = File.new('Users/' + username + '/' + username + '.szi', 'w+')
    userfile.print(username + '-' + password + '-' + usertype)
    userfile.close

    return User.new(username,usertype)
  end

end

class Test
  attr_accessor :name, :questions
  def initialize(args = {})
    @name = args[:name]
    @questions = []
  end

  def self.build(test)

    if test.questions.count.to_s == "0"
      puts ""
      puts "Adding first question..."
      
      option = "yes"
    else
      puts ""
      puts "test currently has " + test.questions.count.to_s + " questions"
      print "add a new question? (yes or no)"

      option = gets.chomp.downcase
      until option == "yes" || option == "no"
        puts "must be yes or no"
        option = gets.chomp.downcase
      end
    end

    case option
    when "yes"
      question = Question.new()
      test.questions.push(question)
      self.build(test)
    when "no"
      testData = File.new('Tests/' + test.name + '/' + test.name + '.szi', 'w+')
      test.questions.each do |q|
        testData.print(q.question.to_s + "-")
        testData.print(q.type.to_s + "-")
        temp = q.options.to_s
        testData.print(temp[1..temp.length-2] + "-")
        testData.print(q.answer.to_s + "-")
        testData.print(";")
      end
      testData.close
      return
    end
  end

  def self.pickTest(username)
    puts ""
    tests = Dir.children('Tests/')
    puts "Choose a test:"
    puts tests
    test = gets.chomp
    tests.each do |i|
      if test == i
        puts "You chose #{test}"
        return test
      else
        next
      end
    end
    puts "unknown test: " + test.to_s + " try again"
    return self.pickTest(username)
  end

  def self.parseTest(test, username)
    puts ""
    finalQuestions = []
    #Build test
    testContent = File.read('Tests/' + test + '/' + test + '.szi')

    testQuestions = testContent.split(';') # array of quesions

    testQuestions.each do |question|
      questionInfo = question.split("-")

      finalQuestions.push(TestQuestion.new(questionInfo[0],questionInfo[1],questionInfo[2].split(","),questionInfo[3]))

    end #Done building test
    return [finalQuestions, username, test]
  end

  def self.takeTest(args)
    questions = args[0]
    username = args[1]
    testname = args[2]
    puts ""
    score = 0

    questions.each do |question|
      puts ""
      puts question.question

      case question.type
      when "TF"
      puts "(T) True or (F) False?"
      choice = gets.chomp.downcase
      until choice == "t" || choice == "f"
        puts "must be t or f"
        choice = gets.chomp.downcase
      end

      when "MC"
        letter = "A"
        question.options.each do |option|
          print letter + ": "
          puts option.strip.strip

          letter = letter.succ
        end
        choice = gets.chop.downcase
        until choice == "a" || choice == "b" || choice == "c" || choice == "d"
          puts "must be a, b, c, or d"
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
        puts "The blank is " + (question.answer.length).to_s + " long"
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
    puts ""
    puts "Final score is " + score.to_s + "/" + questions.count.to_s
    percentage = ((score.to_f/questions.count.to_f) * 100).round(2)
    puts "%" + percentage.to_s + ". Nice!"

    scorefile = File.new('Users/' + username + "/scores/" + testname.to_s + ".szi", 'w+')
    scorefile.puts "Your final score was " +  percentage.to_s + "%, good job!"
    scorefile.close
  end

  def self.viewScores(username)
    puts ""
    tests = Dir.children('Users/' + username + '/scores/')
    tests.each do |test|
      puts test.delete_suffix('.szi')
    end
    test = gets.chomp
    puts "You chose #{test}"
    tests.each do |i|
      if test + '.szi' == i
        score = File.read('Users/' + username + '/scores/' + test + '.szi')
        puts score
      end
    end
  end

  def self.newTest()
    puts ""
    print "name of test:"
    name = gets.chomp
    until name != ""
      puts "must have a name"
      print "name of test:"
      name = gets.chomp
    end

    tests = Dir.children("Tests/")
    if tests.include?(name)
      puts "That has been taken, please choose another"
      return self.newTest()
    end

    Dir.mkdir('Tests/' + name)
    return Test.new(name: name)
  end

  def self.viewTest(args)
    questions = args[0]
    username = args[1]
    testname = args[2]
    puts ""
    questions.each do |question|
      puts ""
      puts "question: " + question.question
      if question.type == "MC"
        puts "options: "
        letter = "A"
        question.options.each do |option|
          print letter + ": "
          puts option.strip.strip
          letter = letter.succ
        end
      end
      puts "answer: " + question.answer
    end
  end
end

class Question
  attr_reader :question, :options, :type, :answer
  def initialize()
    @options = []
    @type = "none"
    puts "what kind of question is it?"
    puts "(0) True/False (1) Multiple Choice (2) Fill in the blank"
    option = gets.chomp
    until option == "0" || option == "1" || option == "2"
      puts "must be 0, 1, or 2"
      option = gets.chomp
    end
    puts "whats the question?"
    @question = gets.chomp
    case option
    when "0"
      @type = "TF"
      @options = ["True","False"]
      puts "what is the answer, (T) True or (F) False"
      @answer = gets.chomp.downcase
      until @answer == "t" || @answer == "f"
        puts "answer must be t or f"
        @answer = gets.chomp.downcase
      end
    when "1"
      @type = "MC"
      puts "A:"
      @options.push(gets.chomp)
      puts "B:"
      @options.push(gets.chomp)
      puts "C:"
      @options.push(gets.chomp)
      puts "D:"
      @options.push(gets.chomp)
      puts "Which one is correct (A)(B)(C)(D)"
      @answer = gets.chomp.downcase
      until @answer == "a" || @answer == "b" || @answer == "c" || @answer == "d"
        puts "Answer must be a, b, c, or d"
        @answer = gets.chomp.downcase
      end
    when "2"
      @type = "FB"
      @options = ["None","None2"]
      puts "what fits in your blank?"
      @answer = gets.chomp
    end
  end
end

app = App.new()
app.start()
