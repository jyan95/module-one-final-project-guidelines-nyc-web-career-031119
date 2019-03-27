require_relative '../lib/api_communicator'

jim = Player.create(username: "jim")
catwoman = Player.create(username: "catwoman")
duckowl = Player.create(username: "duckowl")

15.times do
  q = get_random_question_from_api
  q["style"] = q.delete("type")
  Question.find_or_create_by (q)
end

2.times {QuestionMaster.create(player_id: jim.id, question_id: Question.all.sample.id)}
2.times {QuestionMaster.create(player_id: catwoman.id, question_id: Question.all.sample.id)}
2.times {QuestionMaster.create(player_id: duckowl.id, question_id: Question.all.sample.id)}
