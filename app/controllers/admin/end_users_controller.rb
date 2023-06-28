class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_end_user, only: [:show, :edit, :update]

  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user)
    else
      render 'edit'
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:end_user_name, :email, :is_active)
  end

  def ensure_end_user
    @end_user = EndUser.find(params[:id])
  end

end
