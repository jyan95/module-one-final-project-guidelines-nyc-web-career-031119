require_relative '../config/environment'
require 'json'


def login(username)
  player = Player.validate(username)
  if player
    puts "Here to try your luck again, #{player.username}...?"
  else
    player = Player.new_user(username)
    puts "Welcome to my game, #{player.username}!"
  end
  @current_player = player
  @score = 0
  @streak = 0
  @life = 3
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

def correct?(question, answer)
  q = QuestionMaster.find_by(question_id: question.id, player_id: @current_player.id)

  if question["correct_answer"] == answer
    puts "u rite..."
    q.update_correct(true)
    #increase score!
    case question["difficulty"]
    when 'easy'
      @score += 1
    when 'medium'
      @score += 2
    when 'hard'
      @score += 3
    end
      @streak += 1
  else
    puts "Nice try." #play sound, minus life
    q.update_correct(false)
    @life -= 1
    @streak = 0
  end
end

def dead?
  case @life
  when 3
    puts "Current HP: 3"
  when 2
    puts "Current HP: 2"
  when 1
    puts "Current HP: 1"
  when 0
    puts 'You are dead.'
    true
  end
  # if @life == 0
  #   puts "You have been defeated!!"
  #   false
  # end
end

def game_over
  @current_player.update_streak(@streak) if @streak > @current_player.streak
  @current_player.update_high_score(@score) if @score > @current_player.high_score
end

def start_game
  # puts "Choose a category"
  category, difficulty = get_category_difficulty
  # question = get_random_question_from_api
  # question = get_question(category, difficulty)
  # binding.pry
  questions = generate_questions(category, difficulty)
  asker(questions)
  game_over
end

def get_category_difficulty
  puts "Choose a category #(leave blank for all)"
  puts "-"*30
  Question.display_categories
  num = $stdin.gets.chomp.to_i
  category = Question.get_category_name(num)
  clear_console
  puts "Choose a difficulty (leave blank for all)"
  puts '-'*30
  Question.display_difficulty
  difficulty = $stdin.gets.chomp.downcase
  clear_console
  return category, difficulty
end

def generate_questions(category, difficulty)
  # category, difficulty = get_category_difficulty
  questions_array = []
  until questions_array.length == 4
    question = get_question(category, difficulty)
    question["style"] = question.delete("type")
    # binding.pry
    q = Question.find_or_create_by(question)
    if !validate_question(q)
      questions_array << q
    end
  end
  questions_array
end

#validate_question methods returns a true / false value
def validate_question(question)# current_player)
  !!QuestionMaster.find_by(question_id: question.id, player_id: @current_player.id)
end

def get_answers(q)
  puts "Correct answer is #{q["correct_answer"]}"
  answers = []
  answers << q["correct_answer"]
  answers << JSON.parse(q["incorrect_answers"])
  answers.flatten.shuffle
end

def asker(q_array)
  # binding.pry
  q_array.each do |q|
    puts "-"*25
    puts "Category: #{q["category"]}"
    puts q["question"]
    answers = get_answers(q)
    answers.each_with_index{|a,i| puts "#{i+1} #{a}"}
    # puts q["question"]
    # puts q["correct_answer"]
    # JSON.parse(q["incorrect_answers"]).each do |answer|
    #   puts answer
    # end
    QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
    input = $stdin.gets.chomp.downcase
    if input == "exit"
      exit
    end
    answer = answers[input.to_i-1]
    clear_console
    correct?(q, answer)
    break if dead?
  end
end

def asked?(q)

end


welcome
# new_user?
username = get_username
login(username)
playing = true

while playing
  main_menu
  input = $stdin.gets.chomp.to_i
  case input
  when 1
    clear_console
    start_game
  when 2
    clear_console
    @current_player.stats
  when 3
    clear_console
    Player.scoreboard
    # binding.pry
  when 4
    puts "Are you sure? (y/n)"
    input = $stdin.gets.chomp
    if input == 'y'
      @current_player.reset_questions
      puts '-'*30
      puts 'your questions have been reset'
      puts '-'*30
    end
  when 5
    clear_console
    puts "Cy@"
    playing = false
    # exit
  else
    puts "Please enter a valid number"
  end
end

##ORACLE

#choose mode
  #quickplay
  #normal & sudden_death
    # you've been captured by me - the almightly BIDDLER
    # welcome to my GAME, you can play for your life
    # lose
      # looks like you're dead. maybe you can try again in another life
    # win
      # impressive! you have earned your freedom. until next time!
    # win sudden_death
      # wow! you might just be as smart as me!!


###################################################

# welcome, please enter your username
  # if exists
    # welcome back X
  # else
    # welcome X

# what would you like to do?
  # stats
  # start game
  # reset questions
  # exit

  # stats
    # high_score
    # questions_answered
    # percent_correct

  # start game
    # choose category? (define category or leave blank for all)
    # choose difficulty? (define difficulty or leave blank for all)

# in game
  # get question
  # show current score
  # show current lives
    # if question exists
    # if player has been asked
      # if correct
        # correct message
        # score + 1 (or + difficulty level? / weighted scores)
      # if incorrect
        # incorrect message
        # life - 1, 'you have X lives remaining'
        # if life = 0, exit and you lose message
      # skip?
      # exit
    # if question doesnt exist: save to questions table
    # if player has not answered: save to questionmaster table

##########################################

# extra functionality
  # sudden death? (1 life)
  # challenge mode (hard difficulty only?)
  # casual mode (no lives, no high score, play until user exits)
  # every X amount of questions correct + 1 life?
  # timer? can do delay countdown that automatically - 1 life if they run out of time
