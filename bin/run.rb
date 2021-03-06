require_relative '../config/environment'


def login(username)
  clear_console
  player = Player.validate(username)
  if player
    sleep(0.3)
    puts "Here to try your luck again, #{player.username}...?"
  else
    player = Player.new_user(username)
    sleep(0.3)
    puts "Welcome to my game, #{player.username}!"
  end
  @current_player = player
end

# def reset_game_stats
#   @score = 0
#   @streak = 0
#   @life = 3
# end

# def increase_score(question)
#   #increase score!
#   case question["difficulty"]
#   when 'easy'
#     @score += 1
#   when 'medium'
#     @score += 2
#   when 'hard'
#     @score += 3
#   end
# end

# def correct?(question, answer)
#   qm = QuestionMaster.find_by(question_id: question.id, player_id: @current_player.id)
#
#   if question["correct_answer"] == answer
#     right_answer
#     qm.update_correct(true)
#     increase_score(question)
#     @streak += 1
#   else
#     wrong_answer #play sound, minus life
#     qm.update_correct(false)
#     @life -= 1
#     @streak = 0
#   end
# end

def dead?
  case @life
  when 3
    puts "Health: [* * *]"
  when 2
    puts "Health: [* * -]"
  when 1
    puts "Health: [* - -]"
  when 0
    puts 'Health: [- - -]'
    puts 'You are dead.'
    true
  end
end

# def game_over
#   @current_player.update_streak(@streak) if @streak > @current_player.streak
#   @current_player.update_high_score(@score) if @score > @current_player.high_score
# end

def classic
  clear_console
  gamemode = Classic.new(@current_player)
  gamemode.reset_game_stats
  # puts "Choose a category"
  category, difficulty = get_category_difficulty
  questions = Question.generate_questions(category, difficulty, @current_player)
  gamemode.asker(questions)
  gamemode.game_over
end

def quickplay
  clear_console
  gamemode = Quickplay.new(@current_player)
  gamemode.reset_game_stats
  gamemode.asker
  gamemode.game_over
end

def sudden_death
  clear_console
  gamemode = Suddendeath.new(@current_player)
  gamemode.reset_game_stats
  gamemode.asker
  gamemode.game_over
end

# def start_game
#   gamemode = Classic.new(@current_player)
#   gamemode.reset_game_stats
#   # puts "Choose a category"
#   category, difficulty = get_category_difficulty
#   questions = Question.generate_questions(category, difficulty, @current_player)
#   gamemode.asker(questions)
#   gamemode.game_over
# end

# def asker(q_array)
#   q_array.each do |q|
#     delineate_30
#     puts "Category: #{q["category"]}"
#     puts q["question"]
#     answers = q.get_answers
#     answers.each_with_index{|a,i| puts "#{i+1} #{a}"}
#
#     QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
#     input = get_input_from_player
#     exit?(input)
#     answer = answers[input.to_i-1]
#     clear_console
#     correct?(q, answer)
#     break if dead?
#   end
# end

# def exit?(input)
#   exit if input == "exit"
# end

def play
  playing = true
  while playing
    main_menu
    input = get_input_from_player.to_i #cli
    case input
    when 1
      clear_console #cli
      choose_mode
      # start_game
        # quickplay
        # normal_mode
        # sudden_death
    when 2
      clear_console #cli
      @current_player.stats
    when 3
      clear_console #cli
      Player.scoreboard
    when 4
      warning #cli
      input = get_input_from_player
      if input == 'y'
        @current_player.reset_questions
        delineate_30
        puts 'your questions have been reset'
        delineate_30
      end
    when 5 #exit
      clear_console #cli
      cya
      playing = false
    else
      invalid_input
    end
  end
end

def choose_mode
  puts 'Choose Mode:'
  delineate_30
  puts "1 Quickplay - Hone your skills. \n(category:all, difficulty:all, 'm'-main menu, 'exit'-quit game)"
  puts "\n2 Classic - Play for your freedom! But every question you get wrong brings you closer to your Demise. \n(category:choose, difficulty:choose, 'exit'-quit game)"
  puts "\n3 Sudden Death - Make it out alive and I'll give you 1 Million Dollars. Just don't make any mistakes... \n(category:all, difficulty:hard, 'm'-main menu, 'exit'-quit game)"
  print "\nPick a number > "
  input = get_input_from_player.to_i
  case input
  when 1
    quickplay
  when 2
    classic
  when 3
    sudden_death
  else
    invalid_input
    choose_mode
  end
end

def run_game
  clear_console
  welcome #cli
  sleep(1)
  username = get_username #cli
  login(username)
  sleep(1)
  play
end

run_game

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
