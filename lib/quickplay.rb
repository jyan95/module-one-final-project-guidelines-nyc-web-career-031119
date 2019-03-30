class Quickplay < Gamemode
  def asker
    while true
      q = Question.quick_question(@current_player)
      puts "m - main menu"
      puts "exit - quit game"
      delineate_30
      puts "Category: #{q["category"]}"
      puts q["question"]
      answers = q.get_answers
      answers.each_with_index{|a,i| puts "#{i+1} #{a}"}

      QuestionMaster.create(question_id: q.id, player_id: @current_player.id)
      print "\n> "
      input = get_input_from_player
      exit?(input)
      if input == "m"
        clear_console
        @high_score = 0
        puts "I hope you feel smarter now, maybe next time you'll play for real."
        break
      end
      answer = answers[input.to_i-1]
      clear_console
      correct?(q, answer)
      @high_score = 0
    end
  end
end
