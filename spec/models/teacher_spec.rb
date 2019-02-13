require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'validation tests' do
    it 'ensures email presence' do
      teacher = Teacher.new().save
      expect(teacher).to eq(false)
    end

    it 'should save successfully' do
      teacher = Teacher.new(email: "abc@example.com").save
      expect(teacher).to eq(true)
    end

    it 'should have a correct email address format' do
      teacher = Teacher.new(email: "abc@gmcom").save
      expect(teacher).to eq(true)
    end

    it 'should have unique email address' do
      Teacher.new(email:'abc@example.com').save
      expect {Teacher.new(email:'abc@example.com').save}.to raise_error
    end
  end
end
