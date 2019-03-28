def welcome
  puts "WELCOME TO MY GAME"
end

def get_username
  puts "please enter your username"
  username = $stdin.gets.chomp.downcase
end

def main_menu
  puts "Here are your options:"
  puts "1. Start Game"
  puts "2. Stats"
  puts "3. Scoreboard"# scoreboard
  puts "4. Reset Your Questions"
  puts "5. Exit"
  print "Please enter a number: "
end

def prompt
  puts "here are your options"
end

def clear_console
  system('clear')
end

def get_input_from_player
  input = $stdin.gets.chomp.downcase
end

def invalid_input
  puts "Please enter a valid number"
end

def warning
  puts "Are you sure? (y/n)"
end

def cya
  puts "Cy@"
end
