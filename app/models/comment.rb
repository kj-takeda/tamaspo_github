class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :match

  ##中間テーブルアソシーエーション(エントリー用)
  has_many :comment_goods , dependent: :destroy
  has_many :users, through: :comment_goods

  has_many :notifications, dependent: :destroy

  accepts_nested_attributes_for :comment_goods , allow_destroy: true

  validates :body, presence: true , length: { maximum: 200 } 

  ##commentが持つresponseを検索して最新コメント5件を表示
  def response_limit(comment_id)
    return responses.where(comment_id: comment_id).order(id: "DESC").limit(5)
   end

   ##commentが持つresponseを検索して最新コメント5件を表示
  def response_last(comment_id)
    return responses.where(comment_id: comment_id).order(id: "DESC").limit(1)
   end

   ##commentがコメント削除リンクを表示
   def comment_existence(comment_id)
    Comment.where(id: comment_id).exists?
   end


   def save_notification_Commnet_good!(current_user, user_id, comment_id)
      notification = current_user.active_notifications.new(
        visitor_id: current_user.id,
        visited_id: user_id,
        comment_id: comment_id,
        action: 'Comment_good'
      )
      # 自分の投稿に対するエントリーの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        #自分いいねが通知済みで自分に通知されない
        notification.checked = true
      end
      notification.save if notification.valid?
    end
    
end
