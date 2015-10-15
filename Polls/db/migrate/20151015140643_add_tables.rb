class AddTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
    end

    create_table :polls do |t|
      t.string :title     #limited to 250ish char
      t.integer :author_id
    end

    create_table :questions do |t|
      t.text :question    #text is unlimited length
      t.integer :poll_id
    end

    create_table :answer_choices do |t|
      t.text :answer_choice
      t.integer :question_id
    end

    create_table :responses do |t|
      t.integer :answer_choice_id
      t.integer :user_id      #who made the response
    end

    #add index in POLLS table, for user_id
    add_index :polls, :author_id      #check whether a user id can appear more than once in polls table -> NOT UNIQUE
    add_index :questions, :poll_id    #not unique required; poll has multiple questions
    add_index :answer_choices, :question_id
    add_index :responses, [:answer_choice_id, :user_id], unique: true   #compounded index, creates an index for the pair of answer choice, user
  end
end
