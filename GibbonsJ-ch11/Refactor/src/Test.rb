class Test
  attr_reader :name, :questions
  def initialize(name, questions = [])
    puts ""
    puts "New test initialized: " + name
    @name = name
    @questions = questions
  end

  def self.newTest()
    clearScreen()
    puts ""
    puts "Welcome to the test builder module"

    puts ""
    puts "What is the name of the test?"
    print "Name: "
    name = gets.chomp

    tests = Dir.children("Tests/")

    while tests.include?(name)
      puts ""
      puts "That test already exists."

      puts ""
      puts "What is the name of the test?"
      print "Name: "
      name = gets.chomp
    end

    Dir.mkdir('Tests/' + name)

    test = Test.new(name)
    test.build()
  end

  def build()
    clearScreen()
    puts ""
    puts "Building on test: " + @name
    puts "There are " + @questions.count.to_s + " questions in this test"

    action = ""

    if @questions.count == 0
      action = "yes"
    end

    until action == "yes" || action == "no"
      puts ""
      puts "Would you like to add another question?"
      print "Yes or no: "
      action = gets.chomp.downcase
    end

    case action
    when "yes"
      addQuestion()
      build()
    when "no"
      puts ""
      puts "Saving Test..."

      testData = File.new('Tests/' + @name + '/' + @name + '.szi', 'w+')
      @questions.each do |q|
        testData.print(q.question.to_s + "-")
        testData.print(q.type.to_s + "-")
        temp = q.options.to_s
        testData.print(temp[1..temp.length-2] + "-")
        testData.print(q.answer.to_s + "-")
        testData.print(";")
      end
      testData.close
      puts ""
      puts "Exiting test builder"
    end
  end

  def addQuestion()
    puts ""
    puts "What type of question is this?"
    puts "Multiple Choice (MC) , True or False (TF) , Fill in the Blank (FB)"

    type = ""

    until type == "MC" || type == "TF" || type == "FB"
      print "Type: "
      type = gets.chomp.upcase
    end

    case type
    when "MC"
      question = MCquestion.new()
    when "TF"
      question = TFquestion.new()
    when "FB"
      question = FBquestion.new()
    end

    @questions.push(question)
    return
  end

  def self.picker()
    clearScreen()
    puts ""
    tests = Dir.children('Tests/')
    puts "Choose a test:"
    puts tests
    puts ""
    print "Test: "
    test = gets.chomp
    tests.each do |i|
      if test == i
        begin
          return Test.openTest(test)
        rescue
          puts "Test could not be understood by system: " + test.to_s
          return self.picker()
        end
      else
        next
      end
    end
    puts "Unknown test: " + test.to_s + " try again"
    return self.picker()
  end

  def self.openTest(test)
    puts ""
    puts "Reading test data..."

    finalQuestions = []

    testContent = File.read('Tests/' + test + '/' + test + '.szi')
    testQuestions = testContent.split(';') # array of quesions

    testQuestions.each do |question|
      questionInfo = question.split("-")
      finalQuestions.push(TestQuestion.new(questionInfo[0],questionInfo[1],questionInfo[2].split(","),questionInfo[3]))
    end #Done building test
    parsedTest = Test.new(test, finalQuestions)
    return parsedTest
  end

  def view()
    clearScreen()
    puts ""
    puts "Viewing test: " + @name

    @questions.each do |question|
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
    puts ""
    puts "Press return to continue..."
    gets
  end

end
