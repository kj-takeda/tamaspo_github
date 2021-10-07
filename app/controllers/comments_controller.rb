class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :new_notifications
  before_action :first_notifications

  #アクションの前に行われるアクション
  before_action :comment_params , only: [:destroy]

  def new
    #新しいcommentを作る為
  end

  def create
    ##match投稿isをajaxで受け取る
    @match_id = params[:match_id]
    @body = params[:body]

    @comment = Comment.create(body: params[:body] , user_id: current_user.id , match_id: params[:match_id])

    @match = Match.find(@match_id)
    @match.save_notification_comment!(current_user, @match.id ,  @match.user.id)

   
    @comment_count = Comment.where(match_id: params[:match_id]).order(id: "DESC")

    @comment_count = Comment.where(match_id: params[:match_id])

    @comment_indexs_array = []

    @all = 
    { 
      "id" => "" ,
      "body" => "" ,
      "user_name" => "" ,
      "user_id" => "" ,
      "current_user_id" => "" ,
      "comment_count" => ""
     }

        @all['id'] = @comment.id
        @all['body'] = @comment.body
        @all['user_name'] = @comment.user.name
        @all['user_id'] = @comment.user_id
        @all['current_user_id'] = current_user.id
        @all['comment_count'] = @comment_count.length

        @comment_indexs_array.push(@all)

    ##json形式でレスポンス返す
    respond_to do | format |
    format.json
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def edit
     ##編集comment投稿をajaxで受け取る
     @comment_id = params[:comment_id]
    
     @body = params[:body]

     ##編集commentを指定する
     @comment = Comment.find(params[:comment_id])

     @comment.update(body: params[:body])

     @comment_indexs_array = []

    @all = 
    { 
      "id" => "" ,
      "body" => "" ,
      "user_name" => "" ,
      "user_id" => "" ,
      "current_user_id" => "" ,
      "user_comment_goods" => "" ,
      "comment_goods_length" => ""
     }

        @all['id'] = @comment.id
        @all['body'] = @comment.body
        @all['user_name'] = @comment.user.name
        @all['user_id'] = @comment.user_id
        @all['current_user_id'] = current_user.id
        @all['user_comment_goods'] = @comment.user.comment_goods.ids
        @all['comment_goods_length'] = @comment.comment_goods.length

        @comment_indexs_array.push(@all)

    ##json形式でレスポンス返す
    respond_to do | format |
    format.json
    end
   
  end

  def show
    @comment = Comment.find(params[:id])

    @comment_goods = @comment.comment_goods

    @comment_user_ids = []

    @comment_goods.each do |comment_good|
      @comment_user_ids.push(comment_good.user_id)
    end

    @other_user = User.where(id: @comment_user_ids)
    
  end


  def open
    @val = params[:val]
    @match_id = params[:match_id]

    ##他のコメントを見るを押すたびに10件づつ見れるコメント増える
    @comments = Comment.where(match_id: @match_id)

    @comment_array = []

      @all = 
      { 
        "comment_count" => ""
       }

      @all['comment_count'] = @comments.length
      
      @comment_array.push(@all)

    ##json形式でレスポンス返す
    respond_to do |format|
      format.json
    end
  end

  private
  #イベント情報ページ削除を非同期で行う為に必要
  def comment_params
    @comment = Comment.find(params[:id])
  end

  def new_notifications
    @new_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(checked: false)
  end

  def first_notifications
    @first_notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @first_notifications = @first_notifications.first
  end

end
