class User < ApplicationRecord

  before_save { self.email = email.downcase }
  # alternative method with '!' :
  # before_save { email.downcase! }

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
