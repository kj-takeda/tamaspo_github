Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  } 

  root :to => 'places#top'
  resources :places , only: [:index, :new , :create ,:edit,:update] 
  resources :matches , only: [:index, :new , :create , :show]
  resources :comments , only: [:new ,:create , :edit , :show]
  resources :users , only: [:edit ,:update]
  resources :messages , only: [:create]
  resources :notifications , only: [:index]
  resources :reset_passwords
  ########################################################

  #新規で場所を登録する際に駅名を非同期で表示するメソッド
  get '/places/search', to: 'places#search'
  #場所を検索して表示するメソッド
  get '/places/search_index', to: 'places#search_index'
  #場所を非同期で削除する用のルーティング
  delete 'place/:id' => 'places#destroy', as: 'destroy_place'

  #ジャンルリンクをクリックして場所表示させる
  get 'place_search_genre_link/:genre_id' => 'places#search_genre_link', as: 'place_search_genre_link'

  #エリアリンクをクリックして場所表示させる
  get 'place_search_area_link/:area_id' => 'places#search_area_link', as: 'place_search_area_link'

  ##############################################################

  #エントリー機能用のルーティング
  post 'entry/:id' => 'entries#create', as: 'create_entry'
  delete 'entry/:id' => 'entries#destroy', as: 'destroy_entry'

  ##############################################################

  #イベントを非同期で削除する用のルーティング
  delete 'match/:id' => 'matches#destroy', as: 'destroy_match'

  ##############################################################
  #コメントを非同期で削除する用のルーティング
  delete 'comment/:id' => 'comments#destroy', as: 'destroy_comment'
  #全てのコメントを見る用のルーティング
  get 'comment/:id' => 'comments#open', as: 'comment_open'

  #新規コメントができれば自動でアップロード
  get 'comment/create_update' => 'comments#create_update', as: 'comment_create_update'
  #コメントが削除されれば自動でアップロード
  get 'comment/delete_update' => 'comments#delete_update', as: 'comment_delete_update'

  
  #########################################################
  #コメントいいね機能用のルーティング
  post 'comment_good/:id' => 'comment_goods#create', as: 'create_comment_good'
  delete 'comment_good/:id' => 'comment_goods#destroy', as: 'destroy_comment_good'

  #########################################################

  #カレントユーザーが投稿した球技できる場所をリスト表示するマイページ
  get 'user_show_place_index/:id' => 'users#show_place_index', as: 'user_show_place_index'
  #カレントユーザーが投稿した球技できる場所をリスト表示するマイページ
  get 'user_show_match_index/:id' => 'users#show_match_index', as: 'user_show_match_index'

  #カレントユーザーが投稿した球技できる場所をリスト表示するマイページ
  get 'user_show_match_index_other/:id' => 'users#show_match_index_other', as: 'user_show_match_index_other'

  #カレントユーザーが投稿した球技できる場所をリスト表示するマイページ
  get 'user_show_place_index_other/:id' => 'users#show_place_index_other', as: 'user_show_place_index_other'

  #カレントがフォローしたユーザー・非表示設定したユーザー以外を表示
  get 'user/:id' => 'users#search', as: 'user_search'

  #フォローしてくれているが現状友達ではないユーザを表示(カレントが承認していない)
  get 'user_send_request/:id' => 'users#send_request', as: 'user_send_request'
  #フォローしているが現状承認してくれていないユーザーを表示(カレントを承認していない)
  get 'user_get_request/:id' => 'users#get_request', as: 'user_get_request'
  #非表示設定したユーザーを表示
  get 'user_hidden_user_index/:id' => 'users#hidden_user_index', as: 'user_hidden_user_index'
  #友達関係が成立したユーザー
  get 'user_friend_index/:id' => 'users#friend_index', as: 'user_friend_index'

  #他ユーザーの友達一覧
  get 'other_user_friend_index/:id' => 'users#other_user_friend_index', as: 'other_user_friend_index'

  #ユーザー削除のためのアクション
  get 'user_destroy/:id' => 'users#destroy', as: 'user_destroy'

  #ユーザー削除のためのアクション
  get 'user_check/:id' => 'users#check', as: 'user_check'

  get 'user_word_search' => 'users#user_word_search', as: 'user_word_search'

#########################################################
  #フォロー申請用のルーティング
  #フォローを作る
  post 'relationship/:id' => 'relationships#create', as: 'create_relationship'
  #フォローを削除する
  delete 'relationship/:id' => 'relationships#destroy', as: 'destroy_relationship'

#######################################################

  #非表示リストを作成する為のメソッド
  post 'hide_lists/:id' => 'hide_lists#create', as: 'create_hide_lists'
  #非表示リストを削除する為のメソッド
  delete 'hide_lists/:id' => 'hide_lists#destroy', as: 'destroy_hide_lists'
#########################################################

#######################################################

#メッセージやりとりの為のアクション
get 'index/:id' => 'messages#index', as: 'message_index'
#######################################################

#メッセージやりとりの為のアクション
post 'update' => 'notifications#update', as: 'notifications_update'
#######################################################
end


