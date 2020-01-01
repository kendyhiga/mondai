class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  belongs_to :right_answer,
             class_name: 'Answer',
             foreign_key: :right_answer_id,
             optional: true
  has_many :question_topics, dependent: :destroy
  has_many :topics, through: :question_topics

  validates :content, presence: true
end
