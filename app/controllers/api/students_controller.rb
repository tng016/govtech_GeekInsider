class Api::StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_student, only: [:show, :update, :destroy]
  rescue_from Exception, :with => :error_response

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    render json: @students
  end

  # GET /students/1
  # GET /students/1.json
  def show
    render json: @student
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    if @student.save
        render json: @student, status: :created
    else
        render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
  end

  private
    #returns JSON error message
    def error_response(exception)
      render json: { message: exception.message }, status: :bad_request
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:email)
    end
end
