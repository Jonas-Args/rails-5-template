class ApiController < ActionController::Base
  include ApiExceptions
  include CommonResponse
  include CommonAction
  include Authenticator

  protect_from_forgery with: :null_session
  before_action :authenticate_request
  respond_to :json

  def authenticate_request
    fail ExpiredSessionError if current_user.nil? || !current_user
  end
end
