class CreateQuestionTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :question_topics do |t|
      t.references :question, foreign_key: true, null: false
      t.references :topic, foreign_key: true, null: false

      t.timestamps
    end
  end
end
