class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      render json: UserSerializer.new(user).serialized_json
    else
      render json: { }, status: :unauthorized
    end
  end
end
