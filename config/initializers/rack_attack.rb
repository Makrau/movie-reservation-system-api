class Rack::Attack
  ### Configure Cache ###
  Rack::Attack.cache.store = Rails.cache

  ### Throttle Spammy Clients ###
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?("/assets")
  end

  ### Prevent Brute-Force Login Attacks ###
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    if req.path == "/auth/login" && req.post?
      req.ip
    end
  end

  throttle("logins/email", limit: 5, period: 20.seconds) do |req|
    if req.path == "/auth/login" && req.post?
      req.params["email"].to_s.downcase.gsub(/\s+/, "")
    end
  end

  ### Custom Throttle Response ###
  self.throttled_response = lambda do |env|
    now = Time.now
    match_data = env["rack.attack.match_data"]

    headers = {
      "Content-Type" => "application/json",
      "X-RateLimit-Limit" => match_data[:limit].to_s,
      "X-RateLimit-Remaining" => "0",
      "X-RateLimit-Reset" => (now + (match_data[:period] - now.to_i % match_data[:period])).to_s
    }

    [ 429, headers, [ { error: "Muitas requisições. Por favor, tente novamente em alguns minutos." }.to_json ] ]
  end

  ### Safelist Trusted IPs ###
  safelist("allow from localhost") do |req|
    "127.0.0.1" == req.ip || "::1" == req.ip
  end
end
