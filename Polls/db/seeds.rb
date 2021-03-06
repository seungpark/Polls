# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sp = User.create!(user_name: "SeungPark")
jz = User.create!(user_name: "JimmyZeng")
lr = User.create!(user_name: "LilyR")

poll1 = Poll.create!(title: "Age", author_id: sp.id)
poll2 = Poll.create!(title: "Height", author_id: jz.id)
poll3 = Poll.create!(title: "Life", author_id: sp.id)

question1 = Question.create!(question: "How old are you?", poll_id: poll1.id)
question2 = Question.create!(question: "How tall are you?", poll_id: poll2.id)
question3 = Question.create!(question: "How are you doing?", poll_id: poll3.id)

answer1 = AnswerChoice.create!(answer_choice: "0 to 5 yrs", question_id: question1.id)
answer2 = AnswerChoice.create!(answer_choice: "6+ yrs", question_id: question1.id)

answer3 = AnswerChoice.create!(answer_choice: "less than 5 ft", question_id: question2.id)
answer4 = AnswerChoice.create!(answer_choice: "5 ft or over", question_id: question2.id)

answer5 = AnswerChoice.create!(answer_choice: "Well", question_id: question3.id)


response1 = Response.create!(answer_choice_id: 1, user_id: 2)
response2 = Response.create!(answer_choice_id: 3, user_id: 1)
response3 = Response.create!(answer_choice_id: 5, user_id: 2)
response4 = Response.create!(answer_choice_id: 1, user_id: 3)
