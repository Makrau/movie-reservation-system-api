SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w[origin-when-cross-origin strict-origin-when-cross-origin]

  # Strong Content Security Policy
  config.csp = {
    default_src: %w['none'],
    img_src: %w['self' data: https:],
    media_src: %w['self'],
    script_src: %w['self'],
    style_src: %w['self' 'unsafe-inline'],
    connect_src: %w['self'],
    font_src: %w['self'],
    base_uri: %w['self'],
    form_action: %w['self'],
    frame_ancestors: %w['none'],
    object_src: %w['none'],
    require_trusted_types_for: %w['script']
  }

  # Report URI for CSP violations
  config.csp[:report_uri] = [ ENV["CSP_REPORT_URI"] ] if ENV["CSP_REPORT_URI"]

  # HSTS configuration
  config.hsts = "max-age=31536000; includeSubDomains; preload"
end
