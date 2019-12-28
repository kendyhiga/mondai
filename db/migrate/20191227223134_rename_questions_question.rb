class RenameQuestionsQuestion < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question, :content
  end
end
