def welcome
  puts "WELCOME TO MY GAME"
end

def get_username
  puts "please enter your username"
  username = $stdin.gets.chomp.downcase
  username
end

def prompt
  puts "here are your options"
end

def clear_console
  system('clear')
end
