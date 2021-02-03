class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  # override on production with a current_user method
  # that finds a logged in or authenticated user
  def current_user
    @current_user ||= User.emergency_personnel.first
  end
end
