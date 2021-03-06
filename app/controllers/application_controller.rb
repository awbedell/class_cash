class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, except: [:instructor_logged_in?, :student_logged_in?]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:type, :first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:type, :first_name, :last_name, :email, :password, :password_confirmation, :current_password) }
  end

  private def instructor_logged_in?
    unless current_user.type == "Instructor"
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
    @instructor = Instructor.find(current_user.id)
  end

  private def student_logged_in?
    if current_user.type == "Student" && Student.find(current_user.id).disabled
      sign_out current_user
      redirect_to user_session_path, notice: 'Access Denied'
    elsif
      current_user.type != "Student"
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
    @student = Student.find(current_user.id)
  end

  private def logged_in?
    unless current_user.type == "Instructor" or current_user == @student
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
  end

end
