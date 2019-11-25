class User
  def initialize(username,usertype)
    @username = username
    @usertype = usertype
  end

  def self.login(username, password)
    if username == password # read actual info from userfile
      puts "   ^^^   logged into " + username + "   ^^^   "
      usertype = "student" # read this from the userfile
      return User.new(username,usertype)
    else
      puts "   !!!   inccorect login info  !!!   "
      return nil
    end
  end

end

def login()
  print "username:"
  username = gets.chomp
  print "password:"
  password = gets.chomp
  $user = User.login(username,password)
end

def newUser()
  print "username:"
  username = gets.chomp
  print "password:"
  password = gets.chomp
  print "student or admin:"
  type = gets.chomps
  $user = User.newUser(username,password,type)
end
