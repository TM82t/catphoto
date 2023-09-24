# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_end_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # ゲストログイン用
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to root_path
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_inactive_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && !@end_user.is_active
        flash[:alert] = "このユーザーは退会済みです。申し訳ございませんが、新たに登録いただきますようお願いいたします。"
        redirect_to new_end_user_registration_path
      end
    else
      flash[:alert]
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
