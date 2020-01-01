class QuestionTopic < ApplicationRecord
  belongs_to :question
  belongs_to :topic

  validates :question, presence: true,
                       uniqueness: { scope: :topic }
  validates :topic, presence: true,
                    uniqueness: { scope: :question }
end
