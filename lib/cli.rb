def welcome
  puts "WELCOME TO OUR GAME"
end

def get_username
  puts "please enter your username"
  username = $stdin.gets.chomp.downcase
  username
end

def prompt
  puts "what would you like to do?"
end

def clear_console
  system('clear')
end
