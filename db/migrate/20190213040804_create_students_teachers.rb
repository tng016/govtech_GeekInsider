class CreateStudentsTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :students_teachers, id: false do |t|
      t.belongs_to :student, index: true
      t.belongs_to :teacher, index: true
    end
    add_index :students_teachers, [ :student_id, :teacher_id ], :unique => true, :name => 'by_user_and_role'
  end
end
