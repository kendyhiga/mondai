class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  belongs_to :right_answer,
             class_name: 'Answer',
             foreign_key: :right_answer_id,
             optional: true

  validates :content, presence: true
end
