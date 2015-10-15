class Question < ActiveRecord::Base
  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,   #goes through answer_choices association in line 3
    source: :responses)         #calls responses on AnswerChoice

  validates :poll_id, :question, presence: true

end
