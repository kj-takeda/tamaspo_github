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

  def update
    #カレント以外のユーザーが起こしたアクションレコード
    @current_notifications = Notification.where.not(visitor_id: current_user.id).where(visited_id: current_user.id)

    @new_notifications = @current_notifications.where('id > ?', params[:notifications_id].to_i)

    ##json形式でレスポンス返す
   respond_to do | format |
    format.json
    end
  end

  private

  def new_notifications
    @new_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(checked: false)
  end

  def first_notifications
    @first_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @first_notifications = @first_notifications.first
  end

end
