class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Whitelist the following form fields so that we can process them, if coming from
  # a devise signup form.
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) }
    end
end
