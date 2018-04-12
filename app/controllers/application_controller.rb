class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def require_login
    authenticate_token || render_unauthorized("Access Denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected
    def render_unauthorized(message)
      @errors = { errors: [ {detail: message} ]}
      render json: @errors, status: :unauthorized
    end

  private
    def authenticate_token
      authenticate_with_http_token do |token, options|
        if user = User.with_unexpired_token(token, 15.minutes.ago)
          user
        end
      end
    end
end
