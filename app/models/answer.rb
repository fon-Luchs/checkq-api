class Answer < ApplicationRecord
  belongs_to :question

  validates :name, presence: true

  validates :name, length: { maximum: 250 }
end
