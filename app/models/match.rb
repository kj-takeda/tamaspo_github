class Match < ApplicationRecord
  ##matchテーブルが削除されたら紐づくコメント削除される
  has_many :comments , dependent: :destroy
  ##matchテーブルが削除されたら紐づくエントリー削除される
  has_many :entries , dependent: :destroy
  has_many :users, through: :entries , dependent: :destroy

  ##通知用のアソシエーション
  has_many :notifications, dependent: :destroy

  #matchテーブル/バリデーション
  #50文字以内
  validates :name, presence: true , length: { maximum: 50 } 
  #300文字以内
  validates :event_detail, presence: true , length: { maximum: 500 } 
  
  validates :day, presence: true
  validates :time, presence: true
   ##matchテーブルに紐づく外部キーとアソシエーションを結ぶ
  #外keyは設定した時点で空白NGバリデが効く
  belongs_to :area

  validates :area_detail , presence: true , length:{ maximum: 100 }

  belongs_to :genre

  belongs_to :user
   ##matchテーブルに紐づく外部キーとアソシエーションを結ぶ
  #外keyは設定した時点で空白NGバリデが効く
  
   ##matchテーブルに紐づく外部キーとアソシエーションを結ぶ
  #外keyは設定した時点で空白NGバリデが効く
  
  def match_existence(match_id)
    Match.where(id: match_id).exists?
  end

  ##**アピールコードここから##  
  def save_notification_Entry!(current_user , user_id , match_id)
      notification = current_user.active_notifications.new(
        visitor_id: current_user.id,
        visited_id: user_id,
        match_id: match_id,
        action: 'Entry'
      )
      # 自分の投稿に対するエントリーの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        #自分いいねが通知済みで自分に通知されない
        notification.checked = true
      end
      notification.save if notification.valid?
  end

  def save_notification_comment!(current_user, match_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      match_id: match_id,
      visited_id: visited_id,
      action: 'Comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  ##**アピールコードここまで##  
end
