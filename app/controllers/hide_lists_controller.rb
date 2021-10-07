class HideListsController < ApplicationController
  before_action :authenticate_user!
  before_action :hide_list_params

  #フォロワーになったレコードを作るメソッド
  def create
    @hide_list = HideList.create(user_id: current_user.id , hideuser_id: params[:id])
  end

  #フォロワーになったレコードを作るメソッド
  def destroy
    @hide_list = HideList.find_by(user_id: current_user.id, hideuser_id: params[:id])
    @hide_list.destroy
  end

  private
  def hide_list_params
    @other_user = User.find(params[:id])
  end
end
