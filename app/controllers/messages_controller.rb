class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications
  
  def index
   @receive_user = User.find(params[:id])
   @ids = []
   @ids.push(current_user.id)
   @ids.push(@receive_user.id)

   @messages = Message.where(current_id: @ids).where(partner_id: @ids)

   @current_user = current_user
  end

  def create
    @message_body = params[:body]
    @user_id = params[:user_id]

    @message = Message.create(body: @message_body , current_id: current_user.id , partner_id: @user_id)

    @user = User.find(params[:user_id])

    #メッセージ用の通知レコード作成
    @user.save_notification_message!(current_user , @user.id)

    @message_current_id = @message.current_id
    @message_partner_id = @message.partner_id
    @message_current_name = User.find(@message_current_id).name
    @message_partner_name = User.find(@message_partner_id).name

    @message_current_image = User.find(@message_current_id).image
    @message_partner_image = User.find(@message_partner_id).image

    @message_created = @message.created_at.strftime('%Y年%-m月%-d日 %-H時%-M分')

    @message_indexs_array = []

    @all = 
    { "current_user_id" => "" ,
      "message_current_id" => "" ,
      "message_partner_id" => "" ,
      "message_current_name" => "" ,
      "message_partner_name" => "" ,
      "message_current_image" => "" ,
      "message_partner_image" => "" ,
      "message_created" => "" ,
      "body" => "" 
     }
        @all['current_user_id'] = current_user.id
        @all['message_current_id'] = @message_current_id
        #@all['message_partner_id'] = @message_partner_id
        @all['message_current_name'] = @message_current_name
        #@all['message_partner_name'] = @message_partner_name
        @all['message_current_image'] = @message_current_image
        #@all['message_partner_image'] = @message_partner_image 
        @all['message_created'] = @message_created 
        @all['body'] = @message.body
       
        @message_indexs_array.push(@all)

   ##json形式でレスポンス返す
   respond_to do | format |
    format.json
    end

    @messages = Message.all
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
