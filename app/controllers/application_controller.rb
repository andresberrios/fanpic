require 'application_responder'

class ApplicationController < ActionController::Base
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

  protected

  # Allow unverified requests in development
  def verified_request?
    super || (Rails.env == 'development' && request.headers['hola'] == 'true')
  end
end
