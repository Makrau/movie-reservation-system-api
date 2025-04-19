class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { access_token: token }, status: :created
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end
end
