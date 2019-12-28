class AddRightAnswerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :right_answer_id, :integer, index: true
    add_foreign_key :questions, :answers, column: :right_answer_id
  end
end
