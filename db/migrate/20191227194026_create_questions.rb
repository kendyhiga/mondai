class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true, null: false
      t.string :question, null: false
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
