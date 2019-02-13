class Api::TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_teacher, only: [:show, :update, :destroy]

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
    @teacher = Teacher.where(email: teacher_register_params[0]).take
    @students = Student.where(email: teacher_register_params[1]).all
    @teacher.register_students(@students)
  end

  def commonstudents
    @teachers = Teacher.where(email: collect_teachers_from_query_string).all
    @students = Teacher.get_all_students(@teachers)
    render json: {:students => @students.collect{|student| student.email}}
  end

  def suspend
    @student = Student.where(email: teacher_suspend_params).take
    @student.update_attribute(:is_suspended, 1)
  end

  def notifications
    @teacher = Teacher.where(email: teacher_notification_params[0]).take
    @receipients = @teacher.get_mailing_list(teacher_notification_params[1])
    render json: {:receipients => @receipients.collect{|receipient| receipient.email}}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.permit(:email)
    end

    def teacher_register_params
      params.require([:teacher,:students])
    end

    def teacher_commonstudents_params
      params.require(teacher:[])
    end

    def teacher_suspend_params
      params.require(:student)
    end

    def teacher_notification_params
      params.require([:teacher,:notification])
    end

    def collect_teachers_from_query_string
      current_query_string = URI(request.url).query
      query_params = URI::decode_www_form(current_query_string)
      teachers_array = query_params.select { |pair| pair[0] == "teacher" }.collect { |pair| pair[1] }
    end
end
