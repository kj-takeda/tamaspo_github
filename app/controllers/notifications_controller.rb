class NotificationsController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications
 
  def index
    #カレントユーザーに対してアクションをおこしたユーザー(カレント以外)
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).page(params[:page]).per(10)

    @notifications_check = current_user.passive_notifications.where.not(checked: 1).page(params[:page]).per(10)
     #checkedカラムをfalse→trueに変更
     @notifications_check.where(checked: false).each do |notification|
       notification.update_columns(checked: true)
     end

  end

  ##**アピールコードここから##  
  def update
    #カレント以外のユーザーが起こした通知レコード
    @current_notifications = Notification.where.not(visitor_id: current_user.id).where(visited_id: current_user.id)
    #ブラウザに表示されている通知よりidが大きい通知があればデータを取得
    #データがあれば自動更新される
    @new_notifications = @current_notifications.where('id > ?', params[:notifications_id].to_i)

    ##json形式でレスポンス返す
   respond_to do | format |
    format.json
    end
  end
 
  private

  #カレントユーザー以外がアクションを起こした通知の中でまだチェックしていないものがあれば格納
  #このデータの有無で新着情報ありのビジュアルをコントロールしている
  def new_notifications
    @new_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(checked: false)
  end

  #カレント以外のユーザーが起こした通知レコードで最も最後idを取得
  #こちらのidを元に自動更新の仕組みを作っている
  def first_notifications
    @first_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @first_notifications = @first_notifications.first
  end
  ##**アピールコードここまで##  

end
