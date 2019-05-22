class Question < ApplicationRecord
  belongs_to :subject

  has_many :answers

  validates :name, presence: true

  validates :name, length: { maximum: 250 }
end
