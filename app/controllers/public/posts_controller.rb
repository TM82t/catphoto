class Public::PostsController < ApplicationController

 def new
   @post = Post.new
 end

  def create
    @post = Post.new(post_params)
    @post.end_user_user_id = current_end__user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post  = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end

  private

  def post_params
    params.require(:post).permit(:name, :image, :caption)
  end


end
