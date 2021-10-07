class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  #presenceはnull 空文字共に拒否する #30文字以内で入力する
  validates :name, presence: true , uniqueness: true , length: { maximum: 30 }
  
  #presenceはnull 空文字共に拒否する #50文字以内で入力する
  #@の前は「@」「.ドット」「_アンスコ」「+プラス」いずれかを一つは含ませる
  #@の後は英小文字、数字、-ハイフン、.ドットのいずれか1文字を含む
  #.ドットの後は英小文字を少なくとも1文字以上繰り返す
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true
  validates :email, length: { maximum: 256 }
  validates :email, format: { with: VALID_MAIL_REGEX }

  ##200文字以内で入力する
  validates :introduction , length: { maximum: 300 }

  #ジャンルとの1対1アソシエーション
  #ユーザーテーブルに外key:genre_idを設定
  belongs_to :genre

  validates :password , presence: true

  has_many :matches , dependent: :destroy
  has_many :places , dependent: :destroy

##中間テーブルアソシーエーション(エントリー用)
  has_many :entries , dependent: :destroy
  has_many :matches, through: :entries , dependent: :destroy

  ##中間テーブルアソシーエーション(エントリー用)
  has_many :comment_goods , dependent: :destroy
  has_many :comments, through: :comment_goods , dependent: :destroy

  ##コメント・アソシーエーション
  has_many :comments , foreign_key: :user_id, dependent: :destroy

  ##コメント・アソシーエーション
  has_many :comments , foreign_key: :user_id, dependent: :destroy

  ##コメント・アソシーエーション
  has_many :messages , foreign_key: :current_id, dependent: :destroy

   ##コメント・アソシーエーション
   has_many :messages , foreign_key: :partner_id, dependent: :destroy

  ##メッセージ・アソシーエーション
  ##sender_idがnullではなくreceive_idがnullであれば
  has_many :current_user_messages, -> { where("current_id is not NULL && partner_id is NULL") }, class_name: "Message"
  has_many :partner_user_messages, -> { where("current_id is NULL && partner_id is not NULL") }, class_name: "Message"

  #通知機能用のアソシエーション
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
##フォロー機能を実現するアソシエーション
has_many :relationships , dependent: :destroy
has_many :followings, through: :relationships, source: :follow ,dependent: :destroy

has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id' , dependent: :destroy
has_many :followers, through: :reverse_of_relationships, 
source: :user , dependent: :destroy

##非表示ユーザーを多対多で結ぶアソシエーション
has_many :hide_lists , dependent: :destroy
##中間テービル「hide_lists」を通過してhideuser_idユーザーを取得する
##user.hiddens　ユーザーが非表示にしたユーザーを配列にする
has_many :hiddens, through: :hide_lists, source: :hideuser , dependent: :destroy

##中間テービル「hide_lists」を通過してuser_idユーザーを取得する
##user.hides　非表示にしたユーザーを配列にする
has_many :reverse_of_hide_lists, class_name: 'HideList',
foreign_key: 'hideuser_id' , dependent: :destroy

has_many :hides, through: :reverse_of_hide_lists ,
source: :user , dependent: :destroy

has_one_attached :image

  #カレントユーザーの持つエントリーにmatch_idとmatch.id
  def entry_by?(match_id)
    entries.where(match_id: match_id).exists?
  end

  def comment_liked_by?(comment_id)
    comment_goods.where(comment_id: comment_id).exists?
  end

#フォロー(リクエスト)出している状態
#true フォロー解除　#false フォローする
  def followed_by?(other_user , current_user)
    Relationship.where(user_id:current_user.id).where(follow_id:other_user.id).exists?
  end

  def hided_by?(other_user , current_user)
    HideList.where(user_id:current_user.id).where(hideuser_id: other_user.id).exists?
  end

  #フォロー用の通知機能の為のメソッド
  def save_notification_follow!(current_user , user_id)
      notification = current_user.active_notifications.new(
        visitor_id: current_user.id,
        visited_id: user_id,
        action: 'Follow'
      )
      notification.save if notification.valid?
  end

  #メッセージ用の通知機能の為のメソッド
  def save_notification_message!(current_user, user_id)
    notification = current_user.active_notifications.new(
      visitor_id: current_user.id,
      visited_id: user_id,
      action: 'Message'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  ##carrierwaveアップローダーを使う
  mount_uploader :image, ImageUploader

end
