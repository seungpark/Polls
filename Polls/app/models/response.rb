class Response < ActiveRecord::Base

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  validates :answer_choice_id, :user_id, presence: true
  validate :respondent_has_not_already_answered_question
  #run a private validation with command 'validate'

  def sibling_responses
    if !Response.exists?(self)    #checks if instance is stored in database
      question.responses          #even if instance class = Reponse, returns false if not in database
    else
      self.question.responses
        .where("responses.user_id != ?", respondent.id)
    end

  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:already_answered] << "You cannot answer the same question twice"
    end
  end
  #this method runs before Response has been persisted into database




end
