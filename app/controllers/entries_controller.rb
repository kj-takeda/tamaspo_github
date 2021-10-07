class EntriesController < ApplicationController
  #アクションの前に行われるアクション
  before_action :authenticate_user!
  before_action :match_params

  def create
    @entry = Entry.create(user_id: current_user.id, match_id: params[:id])
    #エントリーしたイベント
  
   @match = Match.find(params[:id])

   @match.save_notification_Entry!(current_user , @match.user.id , @match.id)
    # ここまで
   respond_to :js
  end

  def destroy
    @entry = Entry.find_by(user_id: current_user.id, match_id: params[:id])

    @entry.destroy
    #指定のイベントにカレントユーザーがエントリーしていれば削除
    #@notification = Notification.find_by(visitor_id: current_user.id , match_id: params[:id] , action:"Entry")

    #@notification.destroy

  end

  private
  def match_params
    @match = Match.find(params[:id])
  end

end
