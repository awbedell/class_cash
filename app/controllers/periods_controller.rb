class PeriodsController < ApplicationController
  before_action :logged_in?
  before_action :set_period, only: [:show, :edit, :update, :destroy]


  private def logged_in?
    unless Instructor.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  def enter_behavior
    @period = Period.find_by_instructor_id(session[:user_id])
    @students = @period.students
    @students.each {|s| s.behaviors.build }
  end

  def class_bonus
    @period = Period.find_by_instructor_id(session[:user_id])
  end

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.where(instructor_id: session[:user_id]).all
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @students = @period.students
  end

  # GET /periods/new
  def new
    @period = Period.new
    @instructor = Instructor.find_by_id(session[:user_id])
    20.times { @period.students.build }
  end

  # GET /periods/1/edit
  def edit
    @instructor = Instructor.find_by_id(session[:user_id])
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        @period.pay_students
        format.html { redirect_to root_path, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:instructor_id, :payscale, :name, students_attributes: [:id, :first_name,
          :last_name, :password, :email, behaviors_attributes: [:id, :well_behaved, :date, :did_job]])
    end
end
