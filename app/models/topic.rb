class Topic < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :question_topics
  has_many :questions, through: :question_topics
end
