require 'rails_helper'

RSpec.describe Api::StudentsController, type: :controller do
  describe "GET index" do

    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to have_http_status(200)
    end

    it "returns json of all students" do
      @students = [Student.create(email:"studenta@example.com"),Student.create(email:"studentb@example.com")]
      get :index
      expect(response.body).to eq(@students.to_json)
    end
  end

  describe "GET 'show' " do
    let(:student) { Student.create(email:"studenta@example.com") }

    it "returns a successful 200 response" do
      get :show, params: { id: student }
      expect(response).to have_http_status(200)
    end

    it "returns data of an single student" do
      get :show, params: { id: student }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq("studenta@example.com")
    end

    it "returns an error if the student does not exist" do
      get :show, params: { id: 0 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Couldn't find Student with 'id'=0")
      expect(response).to have_http_status(400)
    end
  end

  describe "POST /students.json when creating new student" do

    it "returns a successful 201 response" do
      post :create, params: { student:{email: 'studentken@example.com'} }, format: :json
      expect(response).to have_http_status(201)
    end

    it "returns json of all created student" do
      post :create, params: { student:{email: 'studentken@example.com'} }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq('studentken@example.com')
    end

    it "returns an error if the student email already registered" do
      Student.create(email:"studentken@example.com")
      post :create, params: { student:{email: 'studentken@example.com'} }, format: :json
      expect(response).to be_bad_request
    end

    it "returns an error if invalid email address given" do
      post :create, params: { student:{email: 'studentkenexample.com'} }, format: :json
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH /students/:id when updating student" do
    let(:student) { Student.create(email:"studentken@example.com") }

    it "returns a successful 200 response" do
      student.email = "studentkenny@example.com"
      patch :update, :params => { id:student.id,student:student.as_json } ,  format: :json
      expect(response).to have_http_status(200)
    end

    it "returns json of updated student" do
      student.email = "studentkenny@example.com"
      patch :update, :params => { id:student.id,student:student.as_json } ,  format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['email']).to eq('studentkenny@example.com')
    end

    it "returns an error if the student email already registered" do
      Student.create(email:"studentkenny@example.com")
      student.email = "studentkenny@example.com"
      patch :update, :params => { id:student.id,student:student.as_json } ,  format: :json
      expect(response).to be_bad_request
    end

    it "returns an error if invalid email address given" do
      student.email = "studentkennyexample.com"
      patch :update, :params => { id:student.id,student:student.as_json } ,  format: :json
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /students/:id when deleting student" do
    let(:student) { Student.create(email:"studentken@example.com") }

    it "returns a successful 204 response" do
      delete :destroy, :params => { id:student.id }
      expect(response).to have_http_status(204)
    end

    it "returns an error if no such student exists" do
      delete :destroy, :params => { id:0 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq("Couldn't find Student with 'id'=0")
      expect(response).to have_http_status(400)
    end
  end
end
