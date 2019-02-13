# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Teacher.create(email: 'teacherken@gmail.com')
Teacher.create(email: 'teacherjane@gmail.com')

Student.create(email: 'studentjon@example.com',is_suspended: 0)
Student.create(email: 'studenthon@example.com',is_suspended: 0)
Student.create(email: 'commonstudent1@example.com',is_suspended: 0)
Student.create(email: 'commonstudent2@example.com',is_suspended: 0)
Student.create(email: 'studentmary@example.com',is_suspended: 0)
Student.create(email: 'studentbob@example.com',is_suspended: 0)
Student.create(email: 'studentagnes@example.com',is_suspended: 0)
Student.create(email: 'studentmiche@example.com',is_suspended: 0)
