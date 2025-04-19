module Admin
  class AuthenticationController < ApplicationController
    # POST /admin/auth/login
    def login
      @admin_user = AdminUser.find_by_email(params[:email])
      if @admin_user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @admin_user.id)
        render json: { access_token: token }, status: :created
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  end
end 