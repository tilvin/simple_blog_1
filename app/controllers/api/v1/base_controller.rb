class Api::V1::BaseController < ActionController::Base

  protect_from_forgery with: :null_session

  def identify_user
    @user = User.find_by_email(JwtProcessor.decode(request.headers[:authorization]))
    render json: { }, status: :unauthorized unless @user
  end

end
