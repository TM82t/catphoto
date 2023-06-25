class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  def show
    @end_user = current_end_user
  end

  def edit
    if @end_user.id != current_end_user.id
      redirect_to end_user_path(current_end_user)
    end
  end

  def update
    if @end_user.update(end_user_params)
      flash[:success] = "会員情報が変更されました。"
      redirect_to end_user_path(current_end_user)
    else
      render "edit"
    end
  end

  private

  def end_user_params
      params.require(:end_user).permit(:name)
  end

end
