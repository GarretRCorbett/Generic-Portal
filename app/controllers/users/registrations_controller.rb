class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, :only => [:create]

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, 
      	:email, :password, :password_confirmation) }
    end
end