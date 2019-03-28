require_relative '../lib/api_communicator'

jim = Player.find_or_create_by(username: "jim")
catwoman = Player.find_or_create_by(username: "catwoman")
duckowl = Player.find_or_create_by(username: "duckowl")

15.times do
  q = get_random_question_from_api
  q["style"] = q.delete("type")
  Question.find_or_create_by (q)
end

2.times {QuestionMaster.find_or_create_by(player_id: jim.id, question_id: Question.all.sample.id)}
2.times {QuestionMaster.find_or_create_by(player_id: catwoman.id, question_id: Question.all.sample.id)}
2.times {QuestionMaster.find_or_create_by(player_id: duckowl.id, question_id: Question.all.sample.id)}
