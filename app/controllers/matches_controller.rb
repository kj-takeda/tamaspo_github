class MatchesController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications
  #アクションの前に行われるアクション
  before_action :match_params2 , only: [:destroy]

  #ページから
  def index
    @comment = Comment.new
    
    #indexページに表示するジャンル検索フォームの項目
    @all_genres = Genre.all

    #indexページに表示するエリア検索フォームの項目
    @all_areas = Area.all

    @current_user = current_user
    #カレントユーザーをフォローしているユーザーのレコードを取得
    @follwer_users = Relationship.where(follow_id:@current_user.id)
    @follower_ids = []
    #カレントユーザーをフォローしているユーザーのidを取得
    @follwer_users.each do | follwer_user |
      @follower_ids.push(follwer_user.user_id)
    end

    #カレントユーザーがフォローしているユーザーレコードを格納
    @following_users = Relationship.where(user_id:@current_user.id)
    @following_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @following_users.each do | following_user |
      @following_ids.push(following_user.follow_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end
    #フォロアーidにカレントユーザーidをプラスする
    @follow_ids.push(current_user.id)

    ##**アピールコードここから##  
    #条件に直接引数を入れず?を入れるのはセキュリティ対策
    #「ユーザー」と「友達関係にあるユーザー」が投稿した情報で
    #todayから7日前までの情報を取得=情報が古くなれば表示されない
    @all_match = Match.where('day >= ?', Date.today-7).where(user_id: @follow_ids).order("day ASC").page(params[:page]).per(10)
    ##**アピールコードここまで##  
  end

  def new
    #新しいmatchを作る為rails 
    @match = Match.new
    @current_user_id = current_user.id
  end

  def create
    @match = Match.new(match_params)
    if @match.save 
      flash[:match_success] = "球技イベント/登録完了しました"
      redirect_to matches_path()
    else
      #エラーメッセージまとめ
      flash[:error] = @match.errors.full_messages
      #データ保存出来なかった時にエラー渡す

      #placeが持つエリアidを格納
      flash[:match_failure] = @match

      flash[:area_id] = @match.area_id

      flash[:genre_id] = @match.genre_id

      redirect_to new_match_path()
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    flash[:match_success] = "球技イベント/削除完了しました"
  end

  def show
    @match = Match.find(params[:id])
  end

  
  private
  def match_params
    params.require(:match).permit(:name, :event_detail, :day, :time, :area_id, :area_detail , :genre_id, :user_id )
  end

  #イベント情報ページ削除を非同期で行う為に必要
  def match_params2
    @match = Match.find(params[:id])
  end

  def new_notifications
    @new_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(checked: false)
  end

  def first_notifications
    @first_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @first_notifications = @first_notifications.first
  end

end
