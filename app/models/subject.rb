class Subject < ApplicationRecord
  has_many :questions

  validates :name, presence: true

  validates :name, length: { in: 4..35 }
end
