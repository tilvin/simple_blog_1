class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post

  def index
    @q = current_user.posts.with_attached_cover_image.ransack(params[:q])
    @posts = @q.result
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :cover_image)
  end

  def find_post
    @post = current_user.posts.find(params[:id]) if params[:id]
  end

end
