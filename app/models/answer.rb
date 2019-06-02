class Answer < ApplicationRecord
  belongs_to :question

  has_one :question_answer

  validates :name, presence: true

  validates :name, length: { maximum: 2500 }
end
