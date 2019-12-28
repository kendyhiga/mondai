class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :content, presence: true

  def right?
    self == question.right_answer
  end
end
