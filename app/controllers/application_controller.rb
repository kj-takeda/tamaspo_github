class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller? 

  private
  #deviseのコントローラはデフォルトで入っているemailとパスワードのみを受け取るストロングパラメータが設定されているので追加したカラムを登録
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name],keys:[:introduction],keys:[:image],keys:[:genre_id], keys:[:password])
    end

    def after_sign_in_path_for(resource)
      root_path # ログイン後に遷移するpathを設定
    end

    def after_sign_out_path_for(resource)
      root_path # ログアウト後に遷移するpathを設定
    end

end
