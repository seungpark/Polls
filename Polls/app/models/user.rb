class User < ActiveRecord::Base
  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,    #from Poll
    primary_key: :id      #from User
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  validates :user_name, presence: true, uniqueness: true

  def completed_polls
    Poll
      .select("polls.*")
      .joins(questions: :answer_choices)
      .joins("LEFT OUTER JOIN (
          SELECT *
          FROM responses
          WHERE #{self.id} = responses.user_id
        ) AS user_responses
        ON answer_choices.id = user_responses.answer_choice_id"
      )
      .group("polls.id")
      .having("COUNT(DISTINCT questions.id) = COUNT(user_responses.id)")
  end






end
#user has many authored polls
