class Player < ActiveRecord::Base
  has_many :question_masters
  has_many :questions, through: :question_masters

  def self.new_user(username)
    Player.find_or_create_by(username: username)
  end

  def self.validate(username)
    Player.find_by(username: username)
  end

  def stats
    puts "High Score: #{self.high_score}"
    puts "Questions Answered: #{self.questions_answered}"
    puts "Accuracy: #{self.accuracy}%"
  end

  def questions_answered
    #SELECT * FROM QM WHERE user_id = self.id  .length
    self.questions.length
  end

  def accuracy
    #SUM(right) / SUM(wrong) FROM QM where user_id = self.id
    correctness = self.question_masters.where("correct = ?", true).length / questions_answered.to_f
    (correctness*100).round(2)
  end

  def reset_questions
    #  delete from db?
    QuestionMaster.forget_questions(self)
  end

  def longest_streak
    # track longest streak of correct answers
  end
end
