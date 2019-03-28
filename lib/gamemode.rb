class Gamemode
  def initialize(player)
    @current_player = player
  end

  def reset_game_stats
    @score = 0
    @streak = 0
    @life = 3
  end

  def asker(q_array)
    q_array.each do |q|
      delineate_30
      puts "Category: #{q["category"]}"
      puts q["question"]
      answers = q.get_answers
      answers.each_with_index{|a,i| puts "#{i+1} #{a}"}

      QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
      input = get_input_from_player
      exit?(input)
      answer = answers[input.to_i-1]
      clear_console
      correct?(q, answer)
      break if dead?
    end
  end

  def correct?(question, answer)
    qm = QuestionMaster.find_by(question_id: question.id, player_id: @current_player.id)

    if question["correct_answer"] == answer
      right_answer
      qm.update_correct(true)
      increase_score(question)
      @streak += 1
    else
      wrong_answer #play sound, minus life
      qm.update_correct(false)
      @life -= 1
      @streak = 0
    end
  end

  def increase_score(question)
    #increase score!
    case question["difficulty"]
    when 'easy'
      @score += 1
    when 'medium'
      @score += 2
    when 'hard'
      @score += 3
    end
  end

  def game_over
    @current_player.update_streak(@streak) if @streak > @current_player.streak
    @current_player.update_high_score(@score) if @score > @current_player.high_score
  end
end
