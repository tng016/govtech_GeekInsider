class Teacher < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email address" }
  has_and_belongs_to_many :students


  def register_students(students)
    students.each do |student|
      self.students << student
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
    students_tagged = get_students_from_emails(email_addresses)
    mailing_list = (mailing_list+students_tagged).uniq
  end

  private

  def get_students_from_emails(email_array)
    students = email_array.collect {|email_address| Student.where(email:email_address[1..-1]).take }
  end

  def get_emailadresses_from_tags(string)
    tags = string.scan(/@\w*@\w*.[a-z]{,3}/x)
  end
end
