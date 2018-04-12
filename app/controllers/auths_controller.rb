class AuthsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def create
    if user = User.valid_login?(params[:email], params[:password])
      user.renew_token
      send_package(user)
    else
      render_unauthorized("Invalid email or password!")
    end
  end

  def destroy
    current_user.logout
    render json: { message: "Successfully logged out!"}, status: :ok
  end

  private
    def send_package(user)
      render json: { token: user.token, user_id: user.id, username: user.username }
    end
end