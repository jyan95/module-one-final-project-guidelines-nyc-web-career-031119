class QuestionMaster < ActiveRecord::Base
  belongs_to :player
  belongs_to :question

  def self.forget_questions(player)
    # QuestionMaster.find_by(player_id: player.id)
    QuestionMaster.delete(player.questions)
  end

  def update_correct(bool)
    self.update(correct: bool)
  end
end
