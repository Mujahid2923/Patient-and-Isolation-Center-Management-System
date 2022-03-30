class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
  rescue_from CanCan::AccessDenied, with: :access_denied

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def access_denied(error)
    flash[:danger] = error.message
    redirect_to root_path
  end

  def record_not_found(error)
    flash[:danger] = error.message
    redirect_to root_path, status: 404
  end

  def record_not_destroyed(error)
    flash[:danger] = error.message
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name verification_code facility_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name admin])
  end
end
