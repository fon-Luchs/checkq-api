class Question < ApplicationRecord
  belongs_to :subject

  has_many :answers

  has_one :question_answer

  validates :name, presence: true

  validates :name, length: { maximum: 4500 }
end
