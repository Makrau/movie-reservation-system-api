module SecurityLoggable
  extend ActiveSupport::Concern

  private

  def log_security_event(event_type, details = {})
    Rails.logger.info({
      event_type: event_type,
      user_id: current_user&.id,
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      path: request.path,
      method: request.method,
      timestamp: Time.current,
      details: details
    }.to_json)
  end

  def log_failed_login(error_type)
    log_security_event("failed_login", {
      error: error_type,
      email: params[:email]&.gsub(/@.*/, "@***")
    })
  end

  def log_successful_login
    log_security_event("successful_login")
  end

  def log_unauthorized_access
    log_security_event("unauthorized_access")
  end
end
