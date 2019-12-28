class Answer < ApplicationRecord
  belongs_to :user
  has_one :question
end
