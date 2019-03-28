def welcome
  puts "WELCOME TO MY GAME"
end

def get_username
  print "please enter your username: "
  username = $stdin.gets.chomp.downcase
end

def main_menu
  delineate_30
  puts "Here are your options:"
  puts "1 Start Game"
  puts "2 Stats"
  puts "3 Scoreboard"
  puts "4 Reset Your Questions"
  puts "5 Exit"
  delineate_30
  print "Please enter a number: "
end

def prompt
  puts "here are your options"
end

def get_category_difficulty
  puts "Choose a category #(leave blank for all)"
  puts "-"*30
  Question.display_categories
  input = get_input_from_player.to_i
  category = Question.get_category_name(input)
  clear_console
  puts "Choose a difficulty (leave blank for all)"
  puts '-'*30
  Question.display_difficulty
  difficulty = $stdin.gets.chomp.downcase
  clear_console
  return category, difficulty
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

def delineate_30
  puts '-'*30
end

def right_answer
  puts "u rite..."
end

def wrong_answer
  puts "Nice try."
end

def exit?(input)
  # game_over if input == "exit"
  exit if input == "exit"
end

def back_to_menu(input)
  false if input == "m"
end
