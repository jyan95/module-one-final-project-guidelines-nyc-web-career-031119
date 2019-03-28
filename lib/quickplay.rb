class Quickplay < Gamemode
  def asker
    while true
      q = Question.quick_question(@current_player)
      delineate_30
      puts "Category: #{q["category"]}"
      puts q["question"]
      answers = q.get_answers
      answers.each_with_index{|a,i| puts "#{i+1} #{a}"}

      QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
      input = get_input_from_player
      exit?(input)
      break if input == "m"
      answer = answers[input.to_i-1]
      clear_console
      correct?(q, answer)
    end
  end
end
