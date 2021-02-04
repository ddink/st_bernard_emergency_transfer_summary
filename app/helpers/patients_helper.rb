module PatientsHelper

  def show_transfer_summary?
    current_user.emergency_staff?
  end

  def current_user
    if User.emergency_personnel.present?
      @current_user ||= User.emergency_personnel.first
    else
      @current_user ||= User.first
    end
  end

end
