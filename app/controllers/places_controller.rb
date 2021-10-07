class PlacesController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications

  before_action :place_params2 , only: [:destroy]

  # TOPページに表示する検索ジャンル名を表示
  def top
    @all_genres = Genre.all
    @all_areas = Area.all

    #カレントに他ユーザーがリアクションしたテーブルでcheckがまだ=新着情報があれば
  end

  def index
    #indexページに表示するジャンル検索フォームの項目
    @all_genres = Genre.all
    #indexページに表示するエリア検索フォームの項目
    @all_areas = Area.all
  
    @search_genres = params[:genres]
    #indexページに表示するエリア検索フォームのチェックidを文字列として配列に格納
    @search_areas = params[:areas]

    @places = []#チェックしたジャンルを持つplace idを配列に格納
    @place_ids= []##チェックしたジャンルを持つplace_id

    @place_indexs = []

    #place表示結果ページに表示するチェック済み項目
    @genre_checks = []
    @area_checks = []

    #topページでジャンル検索した時
    if (params[:genres]) then
      #チェックボックスのジャンルidを文字列→整数化
      @search_genres = @search_genres.map{|n| n.to_i}
      #チェックされたジャンルのレコードを格納
      @genre_checks += Genre.where(id: @search_genres)

      @places += PlaceGenre.where(genre_id: @search_genres)
      #上記で抽出した中間テーブルidを使いplace_idを取得
      @places.each do | place |
        @place_ids.push(place.place_id)
      end

      rand = Rails.env.production? ? "RANDOM()" : "rand()"
      #placeをランダムシャッフル
      @place_indexs = Place.where(id:@place_ids).order(rand).page(params[:page]).per(10)
      
    elsif(params[:areas]) then
      #チェックボックスのエリアidを文字列→整数化
      @search_areas = @search_areas.map{|n| n.to_i}
      #チェックされたエリアのレコードを格納
      @area_checks += Area.where(id: @search_areas)
      #placeをランダムシャッフル
      rand = Rails.env.production? ? "RANDOM()" : "rand()"

      @place_indexs = Place.where(area_id: @search_areas).order(rand).page(params[:page]).per(10)
    else
      rand = Rails.env.production? ? "RANDOM()" : "rand()"
      #placeをランダムシャッフル
      @place_indexs = Place.all.order(rand).page(params[:page]).per(10)
    end
    
  end

  def new
    #新しいplaceを作る為rails 
    @place = Place.new
    #新しいplaceを作る際に登録エリア全てをチェックボックスで表示
    @all_areas = Area.all
  end

  def create
    #フォームから送られたデータを使いレコード作成
    @place = Place.new(place_params)

    if @place.save
      flash[:place_success] = "球技できる場所/登録完了しました"
      redirect_to places_path()
    else
      #@place = Place.new(place_params)
    
      flash[:error] = @place.errors.full_messages
      #データ保存出来なかった時にエラー渡す
      flash[:place_failure] = @place

      #placeが持つエリアidを格納
      flash[:area_id] = @place.area_id

      #placeが持つジャンル・データ取得
      #ループしてジャンルidを配列に格納
      check_genres = []

      @place.place_genres.each do |genre|
        check_genres.push(genre.genre_id)
      end
      #ジャンルidを配列をビューに渡す
      flash[:place_genres] = check_genres

      #駅名が入力されていれば
      if @place.train then
        #placeが持つ駅名と駅が持つ沿線を格納
        flash[:train_name] = @place.train.name
        flash[:train_line_name] = @place.train.line.name
      end

      redirect_to new_place_path()
    end

  end

  def destroy
    @place_index = Place.find(params[:id])
    @place_index.destroy
    
    # redirect_to controller: :matches, action: :index
    #リダイレクトがあると画面遷移が行われて非同期にならない
  end

  def edit
    @place = Place.find(params[:id])
    flash[:train_name] = @place.train.name
    flash[:train_line_name] = @place.train.line.name
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      flash[:place_success] = "球技スポット/編集完了しました"
      
      redirect_to places_path()
    else
      #@place = Place.new(place_params)
      #エラーメッセージまとめ
      flash[:error] = @place.errors.full_messages

      #編集データを取り出しデータ保存ができなかった時にフォームに渡す
      flash[:place_failure_name] = params[:place][:name]
      flash[:place_failure_tel] = params[:place][:tel]
      flash[:place_failure_area_id] = params[:place][:area_id]
      flash[:place_failure_address] = params[:place][:address]
      flash[:place_failure_url] = params[:place][:url]
      flash[:place_failure_place_detail] = params[:place][:place_detail]
      flash[:place_failure_genre_ids] = params[:place][:genre_ids]
      flash[:place_failure_train_id] = params[:place][:train_id]
      flash[:place_failure_user_id] = params[:place][:user_id]

     

      @train = Train.find(params[:place][:train_id])
      flash[:place_failure_train_name] = @train.name
      flash[:place_failure_line_name] = @train.line.name


      redirect_to edit_place_path()
    end

  end

  ##場所を新規登録する際に駅名をajax検索するメソッド
  def search
    ##キーワードが空白の場合、検索しない
    if(params[:keyword] != "") then
      ##キーワードを含む駅名を格納している配列
      @trains = Train.where("name LIKE(?)", "%#{params[:keyword]}%")
    end

    if(@trains) then
      ##空配列を定義
      @line_trains = []
  
      ##キーワードを含む駅のインスタンスをまとめた配列をループ
      @trains.each do | trains|
        ##空連想配列を定義 ループのたびに空にすることで全ての情報を配列に格納できる
        @line_trains_hash = { "line_name" => "" , "train_name" => "" ,  "train_id" => ""}
        line = Line.find(trains.line_id)
        ##各駅に紐づく沿線名を連想配列:key line_nameに代入
        @line_trains_hash['line_name'] = line.name
        ##各駅の名前を連想配列:key line_nameに代入
        @line_trains_hash['train_name'] = trains.name
    
        ##各駅の名前を連想配列:key line_nameに代入
        @line_trains_hash['train_id'] = trains.id

        ##空配列に沿線名(line_name)駅名(train_name)をキーに持つ連想配列を代入
        @line_trains.push(@line_trains_hash)
      end
    end

    ##json形式でレスポンス返す
    respond_to do |format|
      format.json
    end
  end

  def search_index
    #indexページに表示するジャンル検索フォームの項目
    @all_genres = Genre.all
    #indexページに表示するエリア検索フォームの項目
    @all_areas = Area.all
  
    @search_genres = params[:genres]
    #indexページに表示するエリア検索フォームのチェックidを文字列として配列に格納
    @search_areas = params[:areas]

    @places = []#チェックしたジャンルを持つplace idを配列に格納
    @place_ids= []##チェックしたジャンルを持つplace_id

    @place_indexs = []

    #place表示結果ページに表示するチェック済み項目
    @genre_checks = []
    @area_checks = []

    #topページでジャンル検索した時
    if (params[:genres] && params[:areas]) then
      #チェックボックスのジャンルidを文字列→整数化
      @search_genres = @search_genres.map{|n| n.to_i}
      #チェックされたジャンルのレコードを格納
      @genre_checks = Genre.where(id: @search_genres)

      #チェックボックスのエリアidを文字列→整数化
      @search_areas = @search_areas.map{|n| n.to_i}
      #チェックされたエリアのレコードを格納
      @area_checks = Area.where(id: @search_areas)

      #チェックしたジャンルをもつplace_idを配列で格納
      @places += PlaceGenre.where(genre_id: @search_genres)
      #上記で抽出した中間テーブルidを使いplace_idを取得
      @places.each do | place |
        @place_ids.push(place.place_id)
      end

      rand = Rails.env.production? ? "RANDOM()" : "rand()"
      @place_indexs = Place.where(id:@place_ids).where(area_id: @search_areas).order(rand).page(params[:page]).per(10)

    #topページでジャンル検索した時
    elsif (params[:genres]) then
      #チェックボックスのジャンルidを文字列→整数化
      @search_genres = @search_genres.map{|n| n.to_i}
      #チェックされたジャンルのレコードを格納
      @genre_checks = Genre.where(id: @search_genres)

      @places += PlaceGenre.where(genre_id: @search_genres)
      #上記で抽出した中間テーブルidを使いplace_idを取得
      @places.each do | place |
        @place_ids.push(place.place_id)
      end
      rand = Rails.env.production? ? "RANDOM()" : "rand()"
      @place_indexs = Place.where(id:@place_ids).order(rand).page(params[:page]).per(10)
      
    elsif(params[:areas]) then
      #チェックボックスのエリアidを文字列→整数化
      @search_areas = @search_areas.map{|n| n.to_i}
      #チェックされたエリアのレコードを格納
      @area_checks = Area.where(id: @search_areas)

      rand = Rails.env.production? ? "RANDOM()" : "rand()"
      @place_indexs = Place.where(area_id: @search_areas).order(rand).page(params[:page]).per(10)
    end

  end


  ##indexページのサイドバーのジャンルリンクをクリックした時のaction
  def search_genre_link
    @search_genres = params[:genre_id]
   
    @places = []
    @place_ids= []
    @place_indexs = []
    @genre_checks = []
  
    #indexページに表示するジャンル検索フォームの項目
    @all_genres = Genre.all
    #indexページに表示するエリア検索フォームの項目
    @all_areas = Area.all
    #indexページに表示するジャンル検索フォームのチェックidを文字列として配列に格納
  
    @search_genres = @search_genres.to_i
    
    @places += PlaceGenre.where(genre_id: @search_genres)
    
    #上記で抽出した中間テーブルidを使いplace_idを取得
    @places.each do | place |
      @place_ids.push(place.place_id)
    end

    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @place_indexs = Place.where(id: @place_ids).order(rand).page(params[:page]).per(10)

    #indexページに上に表示する検索ジャンル名
    @genre_checks += Genre.where(id: @search_genres)

  end

  ##indexページのサイドバーのエリアリンクをクリックした時のaction
  def search_area_link
    #indexページに表示するジャンル検索フォームの項目
    @all_genres = Genre.all
    #indexページに表示するエリア検索フォームの項目
    @all_areas = Area.all
    #indexページに表示するジャンル検索フォームのチェックidを文字列として配列に格納
    @search_areas = params[:area_id]

    @places = []#チェックしたジャンルを持つplace idを配列に格納
    @place_ids= []##チェックしたジャンルを持つplace_id
    @place_indexs = []

    @search_areas = @search_areas.to_i

    @area_checks = []

    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @place_indexs = Place.where(area_id: @search_areas).order(rand).page(params[:page]).per(10)

    @area_checks += Area.where(id: @search_areas)
  end

  private
    def place_params
      params.require(:place).permit(:name, :tel, :address, :url, :place_detail, :area_id, :train_id, :user_id , { genre_ids: [] })
    end

  #場所情報ページ削除を非同期で行う為に必要
  def place_params2
    @place_index = Place.find(params[:id])
  end

  def new_notifications
    #まだカレントユーザーに届いた新着でまだチェックしてない情報
    @new_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(checked: false)
  end

  def first_notifications
    @first_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @first_notifications = @first_notifications.first
  end

end





