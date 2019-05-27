class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { in: 8..72 }, allow_nil: true

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { in: 3..15 }

  enum state: { user: 1, admin: 2 }
end
