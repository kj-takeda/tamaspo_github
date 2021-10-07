class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :relationship_params

  #フォロワーになったレコードを作るメソッド
  def create
    @relationship = Relationship.create(user_id: current_user.id , follow_id: params[:id])

    #フォローしたユーザー
    @user = User.find(params[:id])

    @user.save_notification_follow!(current_user , @user.id)
    # ここまで
   respond_to :js
  end

#フォロワーになったレコードを作るメソッド
  def destroy
    @relationship = Relationship.find_by(user_id: current_user.id, follow_id: params[:id])
    @relationship.destroy
  end

  private
  def relationship_params
    @other_user = User.find(params[:id])
  end

end
