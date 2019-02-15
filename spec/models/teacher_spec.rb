require 'rails_helper'

RSpec.describe Teacher, type: :model do
  subject { described_class.new(email: "john@doe.com") }

  context 'validation tests' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it 'ensures email presence' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'should have a correct email address format' do
      subject.email = "johndoe.com"
      expect(subject).to_not be_valid
    end

    it 'should have unique email address' do
      Teacher.new(email:'abc@example.com').save
      expect {Teacher.new(email:'abc@example.com').save}.to raise_error(StandardError)
    end
  end

  context "Associations" do
    it "has and belongs to many students" do
      assc = described_class.reflect_on_association(:students)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end
  end

  context "register_students Function" do
    it "should be able to register multiple students" do
      students = [Student.new(email: "studenta@example.com"),Student.new(email: "studentb@example.com")]
      subject.send :register_students, students
      expect(subject.students).to eq students
    end

    it "should throw an error if teacher is nil" do
      students = [Student.new(email: "studenta@example.com"),Student.new(email: "studentb@example.com")]
      teacher = nil
      expect{teacher.register_students(students)}.to raise_error(NoMethodError)
    end

    it "should not register any students if students is empty array" do
      students = []
      subject.send :register_students, students
      expect(subject.students).to eq []
    end
  end

  context "self.get_all_students Function" do
    let(:teacher1) { Teacher.create(email:"teacherken@example.com") }
    let(:teacher2) { Teacher.create(email:"teacherjane@example.com") }
    let(:teacher3) { Teacher.create(email:"teacherlisa@example.com") }
    let(:student1) {Student.create(email:"studenta@example.com")}
    let(:student2) {Student.create(email:"studentb@example.com")}
    let(:student3) {Student.create(email:"studentc@example.com")}

    it "should return all students from multiple teachers without duplicates" do
      teacher1.students << student1
      teacher1.students << student2
      teacher2.students << student3
      teacher2.students << student2
      students = Teacher.get_all_students [teacher1,teacher2]
      expect(students).to eq [student1,student2,student3]
    end

    it "should return an empty string if teacher not passed as argument" do
      teacher1.students << student1
      teacher1.students << student2
      teacher2.students << student3
      teacher2.students << student2
      students = Teacher.get_all_students []
      expect(students).to eq []
    end
  end

  context "get_mailing_list Function" do
    let(:teacher1) { Teacher.create(email:"teacherken@example.com") }
    let(:student1) {Student.create(email:"studenta@example.com")}
    let(:student2) {Student.create(email:"studentb@example.com")}
    let(:student3) {Student.create(email:"studentc@example.com")}
    let(:student4) {Student.create(email:"studentd@example.com",is_suspended: true)}

    it "should be able to return all students registered and tagged" do
      teacher1.students << student1
      teacher1.students << student2
      student3
      notification = "hello @"+student3.email
      students = teacher1.get_mailing_list(notification)
      expect(students).to eq [student1,student2,student3]
    end

    it "should not return a suspended student" do
      teacher1.students << student1
      teacher1.students << student2
      teacher1.students << student4
      notification = "hello @"+student4.email
      students = teacher1.get_mailing_list(notification)
      expect(students).to eq [student1,student2]
    end
  end

end
