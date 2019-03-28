class QuestionMaster < ActiveRecord::Base
  belongs_to :player
  belongs_to :question

  def self.forget_questions(player)
    # QuestionMaster.find_by(player_id: player.id)
    QuestionMaster.delete(player.question_masters.ids)
  end

  def update_correct(bool)
    self.update(correct: bool)
  end

  #validate_question methods returns a true / false value
  def self.validate_question(question, current_player)
    !!QuestionMaster.find_by(question_id: question.id, player_id: current_player.id)
  end
end
