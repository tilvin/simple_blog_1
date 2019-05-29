class Api::V1::PostsController < Api::V1::BaseController

  before_action :identify_user

  def index
    posts = @user.posts.with_attached_cover_image
    render json: PostSerializer.new(posts).serialized_json
  end

  def show
    post = @user.posts.find(params[:id])
    render json: PostSerializer.new(post).serialized_json
  end

end
