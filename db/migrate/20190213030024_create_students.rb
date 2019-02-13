class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :email

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
