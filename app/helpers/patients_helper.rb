module PatientsHelper

  def show_transfer_summary?
    current_user.emergency_staff?
  end

  def current_user
    @current_user ||= User.emergency_personnel.first
    @current_user ||= User.first
  end

end
