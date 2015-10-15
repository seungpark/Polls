class AnswerChoice < ActiveRecord::Base

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
  #looks for answer_choice_id in Response
  #with id column in AnswerChoice table

  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )
  #looks for question_id in AnswerChoice
  #with id column in Question table

  validates :answer_choice, :question_id, presence: true

end
