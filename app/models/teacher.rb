class Teacher < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email address" }
  has_and_belongs_to_many :students, :uniq => true


  def register_students(students)
    students.each do |student|
      begin
        self.students << student
      rescue ActiveRecord::RecordNotUnique
        next
      end
    end
  end

  def self.get_all_students(teachers)
    students = []
    teachers.each do |teacher|
      students = (students + teacher.students).uniq
    end
    return students
  end

  def get_mailing_list(notification)
    mailing_list = self.students.where(is_suspended: false).all
    email_addresses = get_emailadresses_from_tags(notification)
    students_tagged = Student.where(email: email_addresses).all
    mailing_list = (mailing_list+students_tagged).uniq
  end

  private

  def get_emailadresses_from_tags(string)
    tags = string.scan(/[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*/)
  end
end
