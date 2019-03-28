class Suddendeath < Gamemode
  def asker
    while true
      break if dead?
      q = Question.hard_question(@current_player)
      delineate_30
      puts "Category: #{q["category"]}"
      puts q["question"]
      answers = q.get_answers
      answers.each_with_index{|a,i| puts "#{i+1} #{a}"}

      QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
      input = get_input_from_player
      exit?(input)
      if input == "m"
        clear_console
        puts "I guess you don't like money..."
        break
      end
      answer = answers[input.to_i-1]
      clear_console
      correct?(q, answer)
      # break if dead?
    end
  end

  def reset_game_stats
    @score = 0
    @streak = 0
    @life = 1
  end

  def game_over
    super
    puts "\nYou never stood a chance." if @life == 0
  end
end
