class Public::PostsController < ApplicationController
  before_action :ensure_currect_end_user, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post)
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

  def search
    if params[:keyword].present?
      @posts = Post.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :image, :introduction)
  end

  def ensure_currect_end_user
    @post = Post.find(params[:id])
    unless @post.end_user.id == current_end_user.id
      redirect_to root_path, notice: "投稿者以外は削除できません。"
    end
  end
end
