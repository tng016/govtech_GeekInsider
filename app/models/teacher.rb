class Teacher < ApplicationRecord
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
end
