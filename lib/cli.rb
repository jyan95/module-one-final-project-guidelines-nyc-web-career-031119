def welcome
  puts "You've been captured by me - The Almighty BIDDLER!!!"
  sleep(0.5)
  puts "\n.....and this time the Ratman isn't here to save the day"
end

def get_username
  puts "\nTell the console your username."
  sleep(0.5)
  print "Enter your username > "
  input = $stdin.gets.chomp.downcase
  if input.length < 1
    invalid_input
    get_username
  else
    username = input
  end
end

def main_menu
  delineate_30
  puts "Here are your options:"
  sleep(0.15)
  puts "\n1 Start Game"
  sleep(0.1)
  puts "\n2 Stats"
  sleep(0.1)
  puts "\n3 Scoreboard"
  sleep(0.1)
  puts "\n4 Reset Your Questions"
  sleep(0.1)
  puts "\n5 Exit"
  sleep(0.1)
  delineate_30
  sleep(0.1)
  print "Pick a number > "
end

def prompt
  puts "Here are your options:"
end

def get_category
  puts "Choose a category (leave blank for all)"
  puts "-"*30
  Question.display_categories
  puts
  print "Pick a number > "
  input = get_input_from_player.to_i
  if input < 0 || input > 24
    invalid_input
    get_category
  else
    category = Question.get_category_name(input)
    category
  end
end

def get_difficulty
  puts "Choose a difficulty (leave blank for all)"
  puts '-'*30
  Question.display_difficulty
  puts
  print "Difficulty > "
  input = get_input_from_player.to_i
  case input
  when 0
    difficulty = ''
  when 1
    difficulty = 'easy'
  when 2
    difficulty = 'medium'
  when 3
    difficulty = 'hard'
  else
    invalid_input
    get_difficulty
  end
  difficulty
end

def get_category_difficulty
  category = get_category
  clear_console
  difficulty = get_difficulty
  clear_console
  return category, difficulty
end

# def get_category_difficulty
#   puts "Choose a category (leave blank for all)"
#   puts "-"*30
#   Question.display_categories
#   puts
#   print "Pick a number > "
#   input = get_input_from_player.to_i
#   category = Question.get_category_name(input)
#   clear_console
#   puts "Choose a difficulty (leave blank for all)"
#   puts '-'*30
#   Question.display_difficulty
#   puts
#   print "Difficulty > "
#   input = get_input_from_player.to_i
#   case input
#   when 1
#     difficulty = 'easy'
#   when 2
#     difficulty = 'medium'
#   when 3
#     difficulty = 'hard'
#   else
#     get_category_difficulty
#   end
#   clear_console
#   return category, difficulty
# end

def clear_console
  system('clear')
end

def get_input_from_player
  input = $stdin.gets.chomp.downcase
end

def invalid_input
  clear_console
  sleep(0.2)
  puts "Valid number..please."
  puts
  sleep(0.3)
end

def warning
  puts "Are you sure? (y/n)"
  puts "> "
end

def cya
  puts "I hope you feel smarter now, maybe next time you'll play for real."
  puts
end

def delineate_30
  puts '-'*30
end

def right_answer
  responses = [
    "Wow! ur soOoOooO Smart!",
    "Lucky guess...",
    "hmm.. didn't think you'd get that one",
    "Well done! you're smarter than a 5th grader",
    "why do you know that...",
    "wooOOooW look at you!"
  ]
  puts "*CORRECT*\n#{responses[rand(0..responses.length-1)]}"
end

def wrong_answer
  responses = [
    "lol nice try..",
    "How did you get that wrong?!",
    "That one was so easy...",
    "wow I can't believe you got that one wrong!",
    "even my dog could've answered that one..",
  ]
  puts "*INCORRECT*\n#{responses[rand(0..responses.length-1)]}"
end

def exit?(input)
  # game_over if input == "exit"
  if input == "exit"
    clear_console
    cya
    exit
  end
end

def back_to_menu(input)
  false if input == "m"
end
