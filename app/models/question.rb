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
  validate :publishable, if: :published

  def publishable
    errors.add(:publishable, 'Must have at least two answers') if answers.size < 2
    errors.add(:publishable, 'Must have at least one topic') unless topics.any?
    errors.add(:publishable, 'Must have an right answer chosen') unless right_answer
  end
end
