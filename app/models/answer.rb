class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :right_answer,
          class_name: 'Question',
          foreign_key: :right_answer_id,
          dependent: :nullify

  validates :content, presence: true

  def right?
    self == question.right_answer
  end
end
