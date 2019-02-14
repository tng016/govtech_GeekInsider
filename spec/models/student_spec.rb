require 'rails_helper'

RSpec.describe Student, type: :model do
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
      assc = described_class.reflect_on_association(:teachers)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end
  end
end
