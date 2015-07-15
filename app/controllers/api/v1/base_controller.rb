class Api::V1::BaseController < ApplicationController
  respond_to :json
  self.responder = ApiResponder

  protect_from_forgery with: :null_session

  # Send the right status codes when there's auth issues
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      render json: {message: "You don't have permissions."}.to_json, status: :forbidden
    else
      render json: {message: 'You need to be logged in.'}.to_json, status: :unauthorized
    end
  end
end
