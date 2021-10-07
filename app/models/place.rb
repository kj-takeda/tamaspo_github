class Place < ApplicationRecord
  ##placeテーブルが削除されたら紐づくplace_genreが削除される
  has_many :place_genres , dependent: :destroy
  has_many :genres, through: :place_genres
 
  accepts_nested_attributes_for :place_genres , allow_destroy: true
  
  #placeテーブル/バリデーション
  #場所名100文字以内 空白NG
  validates :name, presence: true , length: { maximum: 100 } 
  
  #tel
  #11文字or10文字 and 半角数字のみ
  validates :tel, presence: true
  validates :tel, length: { maximum: 11 } 
  validates :tel, numericality: { only_integer: true}
  
  #外keyは設定した時点で空白NGバリデが効く
  belongs_to :area

  #住所詳細　100文字以内 空白NG
  validates :address, presence: true , length: { maximum: 100 }
  #URL 300文字以内
  validates :url , length: { maximum: 300 }
  #住所詳細　2000文字以内 空白NG
  validates :place_detail , presence: true , length: { maximum: 2000 } 
  
  validates :genre_ids , presence: true
  #外keyは設定した時点で空白NGバリデが効く
  belongs_to :train
  #外keyは設定した時点で空白NGバリデが効く
  belongs_to :user 

end
