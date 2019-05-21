class Subject < ApplicationRecord
  validates :name, presence: true

  validates :name, length: { in: 4..20 }
end
