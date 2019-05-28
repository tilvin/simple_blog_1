class JwtProcessor

  def self.encode(email)
    JWT.encode(email, Rails.application.credentials[:jwt_token])
  end

  def self.decode(token)
    data = JWT.decode(token, Rails.application.credentials[:jwt_token]).first
  rescue
    nil
  end

end
