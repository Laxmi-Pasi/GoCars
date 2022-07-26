class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters_for_update, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact])
  end

  def configure_permitted_parameters_for_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :contact])
  end
end
