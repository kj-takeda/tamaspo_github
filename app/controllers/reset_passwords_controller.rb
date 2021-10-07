class ResetPasswordsController < ApplicationController

  def edit
   #入力されたメアドをもつユーザーを格納
   @user = User.find_by(email: params[:user][:email])
   #該当ユーザーが存在しなければ
   unless @user
    flash[:password_error] = "入力したメールアドレスが正しくありません"
    redirect_to new_user_password_path()
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:place_success] = "パスワード/更新完了しました"
      redirect_to root_path()
    else
      flash[:error] = @user.errors.full_messages
      redirect_to edit_reset_password_path()
    end
  end

  private
    def user_params
      params.require(:user).permit(:password)
    end
end
