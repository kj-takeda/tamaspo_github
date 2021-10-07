class CommentGoodsController < ApplicationController

  #アクションの前に行われるアクション
  before_action :comment_params

  def create
    @cooment_good = CommentGood.create(user_id: current_user.id, comment_id: params[:id])
    
    @comment = Comment.find(params[:id])

    @comment.save_notification_Commnet_good!(current_user, @comment.user.id , @comment.id)

   respond_to :js
  end

  def destroy
    @cooment_good = CommentGood.find_by(user_id: current_user.id, comment_id: params[:id])
    @cooment_good.destroy
  end

  private
  def comment_params
    @comment = Comment.find(params[:id])
  end
end
