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

  def results
    # N+1 method
    # count = Hash.new(0)
    # responses.each { |response| count[response.answer_choice] += 1 }
    # count

    # answer_choices.includes(:responses).length
    # This way is not ideal; it causes all responses to be transfered to the client
    # even though we only want to count the number of them. This is wasteful

    #ANSWER IN SQL
    # SELECT
    #   answer_choices.*, COUNT(responses.id)
    # FROM
    #   answer_choices
    # LEFT OUTER JOIN
    #   responses
    # ON
    #   answer_choices.id = responses.answer_choice_id
    # WHERE
    #   answer_choices.question_id = #{self.id}
    # GROUP BY
    #   answer_choices.id

    answer_choices_with_counts = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS answer_choice_count")
      .joins("LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where("answer_choices.question_id = #{self.id}")
      .group("answer_choices.id")

    count = Hash.new
    answer_choices_with_counts.each do |answer_choice|
      count[answer_choice.answer_choice] = answer_choice.answer_choice_count
    end
    count
  end

end
