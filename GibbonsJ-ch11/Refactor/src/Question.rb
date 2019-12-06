TestQuestion = Struct.new(:question, :type, :options, :answer)

class Question
  def initialize(args = {})
    puts "Whats the question?"
    print "Question: "
    @question = gets.chomp
    return @question
  end
end

class MCquestion < Question
  attr_reader :question, :type, :options, :answer
  def initialize(args = {})
    @question = super()
    @options = []
    @type = "MC"
    puts ""
    print "A: "
    @options.push(gets.chomp)
    print "B: "
    @options.push(gets.chomp)
    print "C: "
    @options.push(gets.chomp)
    print "D: "
    @options.push(gets.chomp)
    puts "Which one is correct (A)(B)(C)(D)"
    print "Answer: "
    @answer = gets.chomp.downcase
    until @answer == "a" || @answer == "b" || @answer == "c" || @answer == "d"
      puts "Answer must be a, b, c, or d"
      print "Answer: "
      @answer = gets.chomp.downcase
    end
    return self
  end
end

class TFquestion < Question
  attr_reader :question, :type, :options, :answer
  def initialize(args = {})
    @question = super()
    @type = "TF"
    @options = ["True","False"]
    puts ""
    puts "What is the answer, (T) True or (F) False"
    print "Answer: "
    @answer = gets.chomp.downcase
    until @answer == "t" || @answer == "f"
      puts "Answer must be t or f"
      print "Answer: "
      @answer = gets.chomp.downcase
    end
    return self
  end
end

class FBquestion < Question
  attr_reader :question, :type, :options, :answer
  def initialize(args = {})
    @question = super()
    @type = "FB"
    @options = ["None","None2"]
    puts "What fits in your blank?"
    print "Answer: "
    @answer = gets.chomp
    return self
  end
end
