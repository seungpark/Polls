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

end
#user has many authored polls
