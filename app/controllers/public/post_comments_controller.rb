class Public::PostCommentsController < ApplicationController
  before_action :ensure_correct_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :end_user_id)
  end

  def ensure_correct_end_user
    @comment = Comment.find(params[:id])
    unless @comment.end_user == current_end_user
      redirect_to posts_path, notice: "投稿者以外コメントは削除できません。"
    end
  end

end
