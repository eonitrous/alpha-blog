class User < ActiveRecord::Base

  # association declaration to articles table
  has_many :articles

  # change email field to downcase before saving
  before_save {self.email = email.downcase}

  #validation rules for username field
  validates :username, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 25}
  #validation regex definition for email field
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # validation rules for email field
  validates :email, presence: true, length: { maximum: 105},
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  # require secure password using bcrypt gem 
  has_secure_password

end