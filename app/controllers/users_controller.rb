class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications

  def show_match_index
    @current_user = current_user
    @current_user_id = current_user.id

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

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@current_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids)

    @all_match = Match.where(user_id: @current_user.id).page(params[:page]).per(5)
  end

  def show_place_index
    @current_user = current_user
    @current_user_id = current_user.id

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

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@current_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids)

    @place_indexs = Place.where(user_id: @current_user.id).page(params[:page]).per(5)
  end


  def show_match_index_other
    @other_user_id = params[:id].to_i

    @other_user = User.find(@other_user_id)

    #otherユーザーをフォローしているユーザーのレコードを取得
    @follwer_users = Relationship.where(follow_id:@other_user_id)
    @follower_ids = []
    #otherユーザーをフォローしているユーザーのidを取得
    @follwer_users.each do | follwer_user |
      @follower_ids.push(follwer_user.user_id)
    end

    #otherユーザーがフォローしているユーザーレコードを格納
    @following_users = Relationship.where(user_id:@other_user_id)
    @following_ids = []
    #otherユーザーがフォローをしているユーザーidを格納
    @following_users.each do | following_user |
      @following_ids.push(following_user.follow_id)
    end

    #otherユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@other_user_id)
    @hide_user_ids = []
    #otherユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids)

    @all_match = Match.where(user_id: @other_user_id).page(params[:page]).per(5)
  end

  def show_place_index_other
    @other_user_id = params[:id].to_i

    @other_user = User.find(@other_user_id)

    #otherユーザーをフォローしているユーザーのレコードを取得
    @follwer_users = Relationship.where(follow_id:@other_user_id)
    @follower_ids = []
    #otherユーザーをフォローしているユーザーのidを取得
    @follwer_users.each do | follwer_user |
      @follower_ids.push(follwer_user.user_id)
    end

    #otherユーザーがフォローしているユーザーレコードを格納
    @following_users = Relationship.where(user_id:@other_user_id)
    @following_ids = []
    #otherユーザーがフォローをしているユーザーidを格納
    @following_users.each do | following_user |
      @following_ids.push(following_user.follow_id)
    end

    #otherユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@other_user_id)
    @hide_user_ids = []
    #otherユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids)

    @place_indexs = Place.where(user_id: @other_user_id).page(params[:page]).per(5)
  end


  def search
    @current_user = current_user
    #カレントユーザーがフォローしたユーザーのレコードを格納
    @relationship_users = Relationship.where(user_id:@current_user.id)
    #カレントユーザーをフォローしてくれたユーザーのレコードを格納 
    
    #カレントユーザーが非表示登録したユーザーのレコードを格納
    @hidelist_users = HideList.where(user_id:@current_user.id)
    ##カレントユーザーがフォローした and 非表示登録したユーザーidを格納する配列
    @follow_ids = []
    #カレントユーザーidを配列に格納(自分の情報を表示するのはNG)
    @follow_ids.push(@current_user.id)

    #カレントユーザーがフォローしているユーザーのレコードをループしてidを配列に格納
    @relationship_users.each do | relationship_user |
      @follow_ids.push(relationship_user.follow_id)
    end
    #カレントユーザーが非表示設定したユーザーのレコードをループしてidを配列に格納
    @hidelist_users.each do | hidelist_user |
      @follow_ids.push(hidelist_user.hideuser_id)
    end
    #カレントユーザーandフォローしたユーザーand
    #非表示設定した以外のユーザーレコードを配列化
    @other_users= User.where.not(id: @follow_ids).page(params[:page]).per(8)
  end


  def other_user_friends
    @current_user = current_user
    #カレントユーザーがフォローしたユーザーのレコードを格納
    @relationship_users = Relationship.where(user_id:@current_user.id)
    #カレントユーザーをフォローしてくれたユーザーのレコードを格納 
    
    #カレントユーザーが非表示登録したユーザーのレコードを格納
    @hidelist_users = HideList.where(user_id:@current_user.id)
    ##カレントユーザーがフォローした and 非表示登録したユーザーidを格納する配列
    @follow_ids = []
    #カレントユーザーidを配列に格納(自分の情報を表示するのはNG)
    @follow_ids.push(@current_user.id)

    #カレントユーザーがフォローしているユーザーのレコードをループしてidを配列に格納
    @relationship_users.each do | relationship_user |
      @follow_ids.push(relationship_user.follow_id)
    end
    #カレントユーザーが非表示設定したユーザーのレコードをループしてidを配列に格納
    @hidelist_users.each do | hidelist_user |
      @follow_ids.push(hidelist_user.hideuser_id)
    end
    #カレントユーザーandフォローしたユーザーand
    #非表示設定した以外のユーザーレコードを配列化
    @other_users= User.where.not(id: @follow_ids).page(params[:page]).per(8)
  end



  def get_request
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

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@current_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされているがまだカレントユーザーが承認していないレコードidを配列に格納
    @follower_ids.each do | follower_id |
      unless @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローしてくれているが現状友達ではないUserレコードを取得
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids).page(params[:page]).per(8)
  end


  def send_request
    @current_user = current_user
    #カレントユーザーがフォローしているユーザーのレコードを取得
    @following_users = Relationship.where(user_id:@current_user.id)
    @following_ids = []
    #カレントユーザーがフォローしているがユーザーidを取得
    @following_users.each do | following_user |
      @following_ids.push(following_user.follow_id)
    end

    #カレントユーザーをフォローしているユーザーレコードを取得
    @follwer_users = Relationship.where(follow_id:@current_user.id)
    @follower_ids = []
    #カレントユーザーフォローしているユーザーidを取得
    @follwer_users.each do | follwer_user |
      @follower_ids.push(follwer_user.user_id)
    end

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@current_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローはしているが現状承認してくれていないユーザーidを配列に格納
    @following_ids.each do | following_id |
      unless @follower_ids.include?(following_id)
        @follow_ids.push(following_id)
      end
    end
  
    #カレントユーザーはフォローしているが、
    #現状承認を頂けていないユーザーのみを抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids).page(params[:page]).per(10)
  end

  def hidden_user_index
    @current_user = current_user

    @other_users_id = []
    #カレントユーザーに紐づく非表示ユーザーidを格納
    current_user.hiddens.each do | hidden |
      @other_users_id.push(hidden.id)
    end
    #カレントユーザーに紐づく非表示ユーザーのみ表示
    @other_users = User.where(id: @other_users_id).page(params[:page]).per(10)
  end

  def friend_index
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

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@current_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids).page(params[:page]).per(8)
  end


  def other_user_friend_index
    @other_user = User.find(params[:id])
  
    #ユーザーをフォローしているユーザーのレコードを取得
    @follwer_users = Relationship.where(follow_id:@other_user.id)
    @follower_ids = []
    #カレントユーザーをフォローしているユーザーのidを取得
    @follwer_users.each do | follwer_user |
      @follower_ids.push(follwer_user.user_id)
    end

    #カレントユーザーがフォローしているユーザーレコードを格納
    @following_users = Relationship.where(user_id:@other_user.id)
    @following_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @following_users.each do | following_user |
      @following_ids.push(following_user.follow_id)
    end

    #カレントユーザーが非表示設定したユーザーのidをまとめる
    @hidelist_users = HideList.where(user_id:@other_user.id)
    @hide_user_ids = []
    #カレントユーザーがフォローをしているユーザーidを格納
    @hidelist_users.each do | hidelist_user |
      @hide_user_ids.push(hidelist_user.hideuser_id)
    end

    @follow_ids = []

    #フォローされており、かつカレントユーザーも承認しているレコードidを配列に格納
    @follower_ids.each do | follower_id |
      if @following_ids.include?(follower_id)
        @follow_ids.push(follower_id)
      end
    end

    #フォローされておりかつ承認しているユーザーのみ抽出
    @other_users = User.where(id: @follow_ids)
    @other_users = @other_users.where.not(id: @hide_user_ids).page(params[:page]).per(8)
  end





  def check
    @user = User.find(params[:id])
  end

  def destroy
    #削除するユーザーレコードを指定
    @user = User.find(params[:id])

    #matchテーブルのみuser_id外部キーが正常に機能しない謎の現象が発生したので
    @user_matches = Match.where(user_id:params[:id])
    @user_matches.each do | user_match |
      user_match.destroy
    end

    #matchテーブルのみuser_id外部キーが正常に機能しない謎の現象が発生したので
    @user_messages = Message.where(current_id:params[:id])
    @user_messages.each do | user_message |
      user_message.destroy
    end
    
    @user.destroy
    flash[:place_success] = "ユーザー登録完了しました"
    redirect_to root_path()
  end

  def user_word_search
    
    @serach_word = params[:search]

    @current_user = current_user
    #カレントユーザーがフォローしたユーザーのレコードを格納
    @relationship_users = Relationship.where(user_id:@current_user.id)
    #カレントユーザーをフォローしてくれたユーザーのレコードを格納 
    
    #カレントユーザーが非表示登録したユーザーのレコードを格納
    @hidelist_users = HideList.where(user_id:@current_user.id)
    ##カレントユーザーがフォローした and 非表示登録したユーザーidを格納する配列
    @follow_ids = []
    #カレントユーザーidを配列に格納(自分の情報を表示するのはNG)
    @follow_ids.push(@current_user.id)

    #カレントユーザーがフォローしているユーザーのレコードをループしてidを配列に格納
    @relationship_users.each do | relationship_user |
      @follow_ids.push(relationship_user.follow_id)
    end
    #カレントユーザーが非表示設定したユーザーのレコードをループしてidを配列に格納
    @hidelist_users.each do | hidelist_user |
      @follow_ids.push(hidelist_user.hideuser_id)
    end
    #カレントユーザーandフォローしたユーザーand
    #非表示設定した以外のユーザーレコードを配列化
    #さらにフリーワードで検索
    @other_users = User.where('name LIKE(?)', "%#{params[:search]}%").where.not(id: @follow_ids).page(params[:page]).per(8)
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
