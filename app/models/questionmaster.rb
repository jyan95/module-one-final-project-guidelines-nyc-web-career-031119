class QuestionMaster < ActiveRecord::Base
  belongs_to :players
  belongs_to :questions

  def update_correct(bool)
    self.update(correct: bool)
    # QuestionMaster.update(self.id, correct: bool)
    # sometimes doesnt work?
  end
end
