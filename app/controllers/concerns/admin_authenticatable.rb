module AdminAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_admin_request
    attr_reader :current_admin
  end

  private

  def authenticate_admin_request
    header = request.headers['Authorization']
    unless header.present? && header.start_with?('Bearer ')
      render json: { error: 'unauthorized' }, status: :unauthorized
      return
    end

    token = header.split(' ').last
    begin
      decoded = JsonWebToken.decode(token)
      @current_admin = AdminUser.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end 