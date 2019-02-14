class Api::TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_teacher, only: [:show, :update, :destroy]
  rescue_from Exception, :with => :error_response

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
    render json: @teachers
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    render json: @teacher
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      render json: @teacher, status: :created
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    if @teacher.update(teacher_params)
      render json: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
  end

  def register
    @teacher = Teacher.where(email: register_params[:teacher]).take
    if @teacher.nil?
      raise "Only one teacher email allowed, or no such teacher email found"
    end
    @students = Student.where(email: register_params[:students]).all
    @teacher.register_students(@students)
  end

  def commonstudents
    @teachers = Teacher.where(email: collect_teachers_from_query_string).all
    @students = Teacher.get_all_students(@teachers)
    render json: {:students => @students.collect{|student| student.email}}
  end

  def suspend
    @student = Student.where(email: suspend_params['student']).take
    if @student.nil?
      raise "Only one student email allowed, or no such teacher email found"
    end
    @student.update_attribute(:is_suspended, 1)
  end

  def notifications
    @teacher = Teacher.where(email: notification_params[:teacher]).take
    @receipients = @teacher.get_mailing_list(notification_params[:notification])
    render json: {:receipients => @receipients.collect{|receipient| receipient.email}}
  end

  private
    #returns JSON error message
    def error_response(exception)
      render json: { message: exception.message }, status: :bad_request
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:email)
    end

    def register_params
      params.permit(:teacher,students:[])
    end

    def suspend_params
      params.permit(:student)
    end

    def notification_params
      params.permit(:teacher,:notification)
    end

    def collect_teachers_from_query_string
      current_query_string = URI(request.url).query
      query_params = URI::decode_www_form(current_query_string)
      teachers_array = query_params.select { |pair| pair[0] == "teacher" }.collect { |pair| pair[1] }
    end
end
