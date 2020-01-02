class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :right_answer,
          class_name: 'Question',
          foreign_key: :right_answer_id,
          dependent: :nullify

  validates :content, presence: true,
                      uniqueness: { scope: :question_id }

  def right?
    self == question.right_answer
  end
end
