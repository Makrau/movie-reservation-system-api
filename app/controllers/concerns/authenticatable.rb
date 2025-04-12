module Authenticatable
  extend ActiveSupport::Concern
  include SecurityLoggable

  included do
    before_action :authenticate_request
    attr_reader :current_user
  end

  private

  def authenticate_request
    header = request.headers["Authorization"]
    unless header.present? && header.start_with?("Bearer ")
      log_unauthorized_access
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end

    token = header.split(" ").last
    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      log_unauthorized_access
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end
end
