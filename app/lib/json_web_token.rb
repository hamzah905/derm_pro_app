class JsonWebToken
  # secret to encode and decode token
  if Rails.env.eql? "production"
    HMAC_SECRET = (Rails.application.secret_key_base || 123451234567890) 
  else
    HMAC_SECRET = (Rails.application.credentials.secret_key_base || 123451234567890) 
  end

  def self.encode(payload, exp = 300.years.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end