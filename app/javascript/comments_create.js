$(function () {
    
  $('.new_comment').on('submit' , function() {

  body = $(this).find('.comment-body-input').val();
  match_id = $(this).find('.comment-match-id-input').val();

//コメント表示する大枠の要素を取得
  comment_list = $(this)
  .next('div')
  .find('.index-main-contens-comment-list');

  //コメント表示する大枠の要素を取得
  comment_content = $(this)
  .next('div')
  .find('.index-main-contens-comment-list')
  .find('.index-main-contens-comment-content');

  //コメント数表示の大枠の要素を取得
  entry_comment_count_link = $(this).parent().parent().find('.index-main-contens-entry-comment-count-link');

      $.ajax({
          type: 'post',
          url: '/comments',
          data: { match_id: match_id , body: body},
          dataType: 'json'
        })

        .done(function (data) { 
          //$(other_link).empty()
          $(entry_comment_count_link).empty()
          //1回限定のループでコメント数を更新する
          for (var i=0; i<1; i++) {
           $(entry_comment_count_link).append(
           `<div class="index-main-contens-entry-comment-count">
             コメント数${data[i].comment_count}
            </div>`
            );
           }
          
    if(data[0].user_id = data[0].current_user_id){
          //フォームに入力した内容を非同期でコメント欄に表示
          //コメントを作る最新コメント2件表示になる
          $.each(data, function (index, value) {
           $(comment_list).prepend(
      `<div class="index-main-contens-comment-content">
         <div id="delete-${value.id}">
           <div class="delete-comment-info">
             <p>コメント「${value.body}」を削除します<br>
             ※削除したコメントは復元できませんのでご注意ください</p>
        
              <div class="index-main-contens-flame-delete"> 
                <div class="index-main-comment-delete-summary">
                  <a class="delete-comment-info-link" data-remote="true" rel="nofollow" data-method="DELETE" href="/comment/${value.id}">
                    コメント削除
                  </a>

                  <a class="delete-comment-info-cancel-link">
                    キャンセル
                  </a>
                </div>
              </div>
            </div>

            <div class="edit-comment-info">
              <p>コメント「${value.body}」を編集します<br>
              ※コメントを編集して上書き</p>

              <div class="index-main-contens-flame-edit">
                <div class="index-main-comment-edit-summary">

                  <form class="edit_comment" data-remote="true" action="/comments/${value.id}/edit" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token">

                    <input class="comment-body-input" value="${value.body}" type="text" name="body" id="body">
       
                    <input value="${value.id}" class="comment-id-input" type="hidden" name="comment_id" id="comment_id">

                    <input type="submit" name="commit" value="コメント編集" class="edit-comment-info-link" data-disable-with="コメント編集">
                  </form>

                  <a class="edit-comment-info-cancel-link">
                    キャンセル
                  </a>
                </div>
              </div>
            </div>

            <ul class="index-main-comment-btns"><a class="comment-fa-edit-link"><i class="fas fa-edit fa-lg"></i></a><a class="comment-edit-btn-link"><div class="comment-edit-btn">編集</div></a><a class="comment-delete-btn-link"><div class="comment-delete-btn">削除</div></a></ul>

            <li class="index-main-contens-comment-content-text">
              ${value.body}
            </li>

            <li class="index-main-contens-comment-content-user">
              ${value.user_name}のコメント
            </li>

            <div class="index-main-contens-comment-content-btns">
              <div id="good-${value.id}" ="" class="index-main-contens-comment-content-btn-nice">
                 <a class="index-main-contens-comment-content-btn-nice-link01" 
                 data-remote="true" rel="nofollow" data-method="POST" href="/comment_good/${value.id}">
                   いいね
                 </a>

               <div class="index-main-contens-comment-content-btn-nice-count">
                 0
               </div>
             </div>
          </div>
        </div>
      </div>`)
       })

    }else{
      $.each(data, function (index, value) {
        $(comment_list).prepend(
 
   `<div class="index-main-contens-comment-content">

      <div class="index-main-contens-comment-content-name">コメント</div>
        <li class="index-main-contens-comment-content-text">
         ${value.body}
        </li>

        <li class="index-main-contens-comment-content-user">
         ${value.user_name}のコメント
        </li>

       <div class="index-main-contens-comment-content-btns">
             <div id="good-${value.id}" ="" class="index-main-contens-comment-content-btn-nice">
               <a class="index-main-contens-comment-content-btn-nice-link01" 
            data-remote="true" rel="nofollow" data-method="POST" href="/comment_good/${value.id}">
            いいね
            </a>

              <div class="index-main-contens-comment-content-btn-nice-count">
             0
           </div>
            </div>
      </div>
   </div>`)
    })
    }
   //コメント作成後にフォームに残ったコメント削除
    $('.comment-body-input').val("");

    setTimeout(function () {
      location.reload();
  }, 2000);
    
    })

    .fail(function (data) {
      return false;
    })
  });
});
