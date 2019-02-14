require 'rails_helper'

RSpec.describe Api::TeachersController, type: :controller do
  describe "GET index" do

    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to have_http_status(200)
    end

    it "returns json of all teachers" do
      @teachers = [Teacher.create(email:"teacherken@example.com"),Teacher.create(email:"teacherjane@example.com")]
      get :index
      expect(response.body).to eq(@teachers.to_json)
    end
  end

  describe "GET 'show' " do
    let(:teacher) { Teacher.create(email:"teacherken@example.com") }

    it "returns a successful 200 response" do
      get :show, params: { id: teacher }
      expect(response).to have_http_status(200)
    end

    it "returns data of an single teacher" do
      get :show, params: { id: teacher }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq("teacherken@example.com")
    end

    it "returns an error if the teacher does not exist" do
      get :show, params: { id: 0 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Couldn't find Teacher with 'id'=0")
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /teachers.json when creating new teacher" do

    it "returns a successful 201 response" do
      post :create, params: { teacher:{email: 'teacherken@example.com'} }, format: :json
      expect(response).to have_http_status(201)
    end

    it "returns json of all created teacher" do
      post :create, params: { teacher:{email: 'teacherken@example.com'} }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq('teacherken@example.com')
    end

    it "returns an error if the teacher email already registered" do
      Teacher.create(email:"teacherken@example.com")
      post :create, params: { teacher:{email: 'teacherken@example.com'} }, format: :json
      expect(response).to be_bad_request
    end

    it "returns an error if invalid email address given" do
      post :create, params: { teacher:{email: 'teacherkenexample.com'} }, format: :json
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH /teachers/:id when updating teacher" do
    let(:teacher) { Teacher.create(email:"teacherken@example.com") }

    it "returns a successful 200 response" do
      teacher.email = "teacherkenny@example.com"
      patch :update, :params => { id:teacher.id,teacher:teacher.as_json } ,  format: :json
      expect(response).to have_http_status(200)
    end

    it "returns json of updated teacher" do
      teacher.email = "teacherkenny@example.com"
      patch :update, :params => { id:teacher.id,teacher:teacher.as_json } ,  format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq('teacherkenny@example.com')
    end

    it "returns an error if the teacher email already registered" do
      Teacher.create(email:"teacherkenny@example.com")
      teacher.email = "teacherkenny@example.com"
      patch :update, :params => { id:teacher.id,teacher:teacher.as_json } ,  format: :json
      expect(response).to be_bad_request
    end

    it "returns an error if invalid email address given" do
      teacher.email = "teacherkennyexample.com"
      patch :update, :params => { id:teacher.id,teacher:teacher.as_json } ,  format: :json
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /teachers/:id when deleting teacher" do
    let(:teacher) { Teacher.create(email:"teacherken@example.com") }

    it "returns a successful 204 response" do
      delete :destroy, :params => { id:teacher.id }
      expect(response).to have_http_status(204)
    end

    it "returns an error if no such teacher exists" do
      delete :destroy, :params => { id:0 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Couldn't find Teacher with 'id'=0")
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /register when registering students" do
    let(:teacher1) { Teacher.create(email:"teacherken@example.com") }
    let(:teacher2) { Teacher.create(email:"teacherjane@example.com") }
    let(:student1) {Student.create(email:"studenta@example.com")}
    let(:student2) {Student.create(email:"studentb@example.com")}

    it "returns a successful 204 response" do
      post :register, :params => { teacher:teacher1.email, students:[student1.email,student2.email] }
      expect(response).to have_http_status(204)
      expect(teacher1.students).to eq([student1,student2])
    end

    it "returns an error if multiple teacher emails given" do
      post :register, :params => { teacher:[teacher1.email,teacher2.email], students:[student1.email,student2.email] }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Only one teacher email allowed, or no such teacher email found")
      expect(response).to have_http_status(400)
    end

    it "returns an error if no teacher emails given" do
      post :register, :params => { students:[student1.email,student2.email] }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Only one teacher email allowed, or no such teacher email found")
      expect(response).to have_http_status(400)
    end

    it "returns an error if wrong teacher email given" do
      post :register, :params => { teacher:"teacher1@example.com", students:[student1.email,student2.email] }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Only one teacher email allowed, or no such teacher email found")
      expect(response).to have_http_status(400)
    end

    it "will not register students who are not existing students" do
      post :register, :params => { teacher:teacher1.email, students:[student1.email,"unknownstudent@example.com"] }
      expect(teacher1.students).to eq([student1])
    end

    it "will not register students twice with duplicate email addresses" do
      post :register, :params => { teacher:teacher1.email, students:[student1.email,student1.email] }
      expect(teacher1.students).to eq([student1])
    end

    it "will not duplicate registrations" do
      teacher1.students << student1
      post :register, :params => { teacher:teacher1.email, students:[student1.email] }
      expect(teacher1.students).to eq([student1])
    end
  end

  describe "GET /commonstudents when registering students" do
    let(:teacher1) { Teacher.create(email:"teacherken@example.com") }
    let(:teacher2) { Teacher.create(email:"teacherjane@example.com") }
    let(:teacher3) { Teacher.create(email:"teacherlisa@example.com") }
    let(:student1) {Student.create(email:"studenta@example.com")}
    let(:student2) {Student.create(email:"studentb@example.com")}
    let(:student3) {Student.create(email:"studentc@example.com")}

    it "returns a successful 200 response" do
      teacher1.students << student1
      teacher1.students << student2
      get "commonstudents", :params => {teacher:teacher1.email}
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['students']).to eq([student1.email,student2.email])
    end

    it "returns an empty array if teacher email wrongly given" do
      teacher1.students << student1
      teacher1.students << student2
      get "commonstudents", :params => {teacher:"wrongemail@example.com"}
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['students']).to eq([])
    end
  end

  describe "POST /suspend when suspending students" do
    let(:student1) {Student.create(email:"studenta@example.com")}

    it "returns a successful 204 response" do
      post "suspend", :params => {student:student1.email}
      expect(response).to have_http_status(204)
      student = Student.where(email: student1.email).take
      expect(student.is_suspended).to eq(true)
    end

    it "should raise an error if multiple students given" do
      post "suspend", :params => {student:[student1.email,"studenta@example.com"]}
      expect(response).to have_http_status(400)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Only one student email allowed, or no such teacher email found")
    end

    it "should raise an error if no students given" do
      post "suspend", :params => {student:[]}
      expect(response).to have_http_status(400)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Only one student email allowed, or no such teacher email found")
    end

  end

  describe "POST /notifications when notifying students" do
    let(:teacher1) { Teacher.create(email:"teacherken@example.com") }
    let(:teacher2) { Teacher.create(email:"teacherjane@example.com") }
    let(:teacher3) { Teacher.create(email:"teacherlisa@example.com") }
    let(:student1) {Student.create(email:"studenta@example.com")}
    let(:student2) {Student.create(email:"studentb@example.com")}
    let(:student3) {Student.create(email:"studentc@example.com")}

    it "returns a successful 200 response" do
      teacher1.students << student1
      teacher1.students << student2
      student3
      notification_string ="Hello students! @studentc@example.com"
      post "notifications", :params => {teacher: teacher1.email,notification: notification_string}
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['receipients']).to eq([student1.email,student2.email,student3.email])
    end

    it "should not return wrongly written addresses" do
      teacher1.students << student1
      teacher1.students << student2
      student3
      notification_string ="Hello students! @studentc@example.com@wrongstudent@example.com"
      post "notifications", :params => {teacher: teacher1.email,notification: notification_string}
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['receipients']).to eq([student1.email,student2.email,student3.email])
    end

    it "should raise an error if no teacher given" do
      teacher1.students << student1
      teacher1.students << student2
      student3
      notification_string ="Hello students! @studentc@example.com"
      post "notifications", :params => {notification: notification_string}
      expect(response).to have_http_status(400)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("undefined method `get_mailing_list' for nil:NilClass")
    end

  end

end
