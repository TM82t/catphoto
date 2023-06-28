class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_end_user, only: [:show, :edit, :update]

  def index
    @end_users = EndUser.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @end_user.update(end_user_params) ? (redirect_to admin_end_user_path(@end_user)) : (render :edit)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

  def ensure_end_user
    @end_user = EndUser.find(params[:id])
  end

end
