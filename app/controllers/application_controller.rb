require 'application_responder'

class ApplicationController < ActionController::Base
  #Permit additional parameter username for devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  self.responder = ApplicationResponder
  respond_to :html, :json

  # Send the right status codes when there's auth issues
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      render json: {message: "You don't have permissions."}.to_json, status: :forbidden
    else
      render json: {message: 'You need to be logged in.'}.to_json, status: :unauthorized
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :exception

  # Auto log in when debugging in development environment
  before_action :auto_login if Rails.env == 'development'

  protected
    # Allow unverified requests in development
    def verified_request?
      super || (Rails.env == 'development' && request.headers['hola'] == 'true')
    end

    def auto_login
      sign_in User.find_by(role: 'admin') if Rails.env == 'development' && request.headers['hola'] == 'true'
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end
end
