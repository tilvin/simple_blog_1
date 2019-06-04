module Authenticatable

  include ActiveSupport::Concern

  def authenticate_by_token_and_user!
    User.find_by(email: JwtProcessor.decode(cookies[:token])) || authenticate_user!
  end
end
