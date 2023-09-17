class Public::PostCommentsController < ApplicationController
  before_action :ensure_currect_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = @post.id
    if @comment.save
        redirect_to post_path(@post)
    else
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.new
        flash.now[:alert] = "コメントを入力してから送信するボタンを押してください"
        render 'public/posts/show'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :end_user_id)
  end

  def ensure_currect_end_user
    @comment = PostComment.find(params[:id])
    unless @comment.end_user == current_end_user
      redirect_to posts_path, notice: "投稿者以外コメントは削除できません。"
    end
  end

end
