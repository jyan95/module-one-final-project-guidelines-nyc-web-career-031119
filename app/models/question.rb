require 'JSON'
require 'rest-client'
require 'pry'

class Question < ActiveRecord::Base
  has_many :question_masters
  has_many :players, through: :question_masters

  @categories = {
    "General Knowledge" => 9,
    "Entertainment: Books"=>10,
    "Entertainment: Film"=>11,
    "Entertainment: Music"=>12,
    "Entertainment: Musicals & Theatres"=>13,
    "Entertainment: Television"=>14,
    "Entertainment: Video Games"=>15,
    "Entertainment: Board Games"=>16,
    "Science & Nature"=>17,
    "Science: Computers"=>18,
    "Science: Mathematics"=>19,
    "Mythology"=>20,
    "Sports"=>21,
    "Geography"=>22,
    "History"=>23,
    "Politics"=>24,
    "Art"=>25,
    "Celebrities"=>26,
    "Animals"=>27,
    "Vehicles"=>28,
    "Entertainment: Comics"=>29,
    "Science: Gadgets"=>30,
    "Entertainment: Japanese Anime & Manga"=>31,
    "Entertainment: Cartoon & Animations"=>32,
    0 => ""
  }

  def self.generate_questions(category, difficulty, player)
    questions_array = []
    until questions_array.length == 4
      question = get_question(category, difficulty)
      question["style"] = question.delete("type")
      binding.pry
      q = self.find_or_create_by(question)
      if !QuestionMaster.validate_question(q, player)
        questions_array << q
      end
    end
    questions_array
  end

  def self.display_categories
    @categories.each_with_index { |(category,value), i| puts "#{i+1} #{category}"}
  end

  def self.get_category_name(input)
    if input == 0
      ""
    else
      category_names = []
      @categories.each{|category,id| category_names << category}
      category_names[num-1]
    end
  end

  def self.display_difficulty
    puts "Easy \t Medium \t Hard"
  end

  def get_answers()
    puts "Correct answer is #{self["correct_answer"]}"
    answers = []
    answers << self["correct_answer"]
    answers << JSON.parse(self["incorrect_answers"])
    answers.flatten.shuffle
  end

end
