class Users::RegistrationsController < Devise::RegistrationsController
 # before_action :configure_sign_up_params, only: [:create]
 # before_action :configure_account_update_params, only: [:update]

 
  #新規ユーザ情報を作る時に得意ジャンルを設定する為のメソッド
  def new
    #新ユーザーを作る為
    #新ユーザーが得意ジャンルを決める為に必要
    @all_genres = Genre.all
  end

  def create
    #フォームから送られたデータを使いレコード作成
    @user = User.new(user_params)
    #保存できた場合は、場所一覧ページにリダイレクト
    if @user.save
      flash[:user_success] = "ユーザー登録完了しました"
      redirect_to root_path()
    else
      flash[:error] = @user.errors.full_messages
      flash[:user] = @user
      redirect_to new_user_registration_path()
    end
   
  end

  def edit
    @user = current_user
    @user_image = @user.image
  end

  def update
   @user = User.find(params[:user][:id])
   if @user.update(user_params)
    bypass_sign_in(@user) #自動ログアウトを防ぐコード
     flash[:user_success] = "ユーザー情報/編集完了しました"
     redirect_to root_path()
    else
      flash[:error] = @user.errors.full_messages

      #編集データを取り出しデータ保存ができなかった時にフォームに渡す
      flash[:user_failure_name] = params[:user][:name]
      flash[:user_failure_email] = params[:user][:email]
      flash[:user_failure_image] = params[:user][:image]
      flash[:user_failure_introduction] = params[:user][:introduction]
      flash[:user_failure_genre_id] = params[:user][:genre_id]
      flash[:user_failure_password] = params[:user][:password]
  
      redirect_to edit_user_registration_path()
    end
  end

  private
    def user_params
      params.require(:user).permit(:name , :email , :password , :introduction, :image , :genre_id, :remove_image)
      #remove_imageは画像削除用
    end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
