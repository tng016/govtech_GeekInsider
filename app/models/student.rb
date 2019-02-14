class Student < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email address" }
  has_and_belongs_to_many :teachers, :uniq => true
end
