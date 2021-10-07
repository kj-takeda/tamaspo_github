$(function () {   
  //コメント編集ボタンをクリック※documentは何度でも
  $(document).on('click' , '.edit-comment-info-link',
  function() {

  body = $(this).prev('.comment-id-input').prev('.comment-body-input').val();
  comment_id = $(this).prev('.comment-id-input').val();

  delete_element = $(this).parent().parent().parent().parent().parent()


      $.ajax({
          type: 'get',
          url: '/comments/comment_id/edit',
          data: { comment_id: comment_id , body: body},
          dataType: 'json'
        })

        .done(function (data) {

          console.log(data)

          $(delete_element).empty()

    if(data[0].user_id = data[0].current_user_id && data[0].user_comment_goods.length){
      console.log(data[0]);
      console.log(data[0].comment_goods);

          $.each(data, function (index, value) {
           $(delete_element).prepend(
        `<div id="delete-${value.id}">
           <div class="delete-comment-info">
             <p>コメント「${value.body}」を削除します<br>
             ※削除したコメントは復元できませんのでご注意ください</p>

              <div class="index-main-contens-flame-delete"> 
                <div class="index-main-comment-delete-summary">

                  <a class="delete-comment-info-link" data-remote="true"
                    rel="nofollow" data-method="DELETE" href="/comment/${value.id}">
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

            <ul class="index-main-comment-btns">
              <a class="comment-fa-edit-link">
                <i class="fas fa-edit fa-2x"></i>
              </a>

              <a class="comment-edit-btn-link">
                <div class="comment-edit-btn">編集</div>
              </a>

              <a class="comment-delete-btn-link">
                <div class="comment-delete-btn">削除</div>
              </a>
          
            </ul>

            <li class="index-main-contens-comment-content-text">
              ${value.body}
            </li>

            <li class="index-main-contens-comment-content-user">
              ${value.user_name}のコメント
            </li>
        
            <div class="index-main-contens-comment-content-btns">
              <div id="good-${value.id}" class="index-main-contens-comment-content-btn-nice">
                <a class="index-main-contens-comment-content-btn-nice-link02" 
                data-remote="true" rel="nofollow" data-method="DELETE" href="/comment_good/${value.id}">
                  いいね削除
                </a>
                 
                <div class="index-main-contens-comment-content-btn-nice-count">
                  ${value.comment_goods_length}
                </div>
              </div>
            </div>
          </div>`
        )
       })

       

    }else if(data[0].user_id = data[0].current_user_id){
      $.each(data, function (index, value) {
        $(delete_element).prepend(
 
     `<div id="delete-${value.id}">
        <div class="delete-comment-info">
          <p>コメント「${value.body}」を削除します<br>
          ※削除したコメントは復元できませんのでご注意ください</p>

           <div class="index-main-contens-flame-delete"> 
             <div class="index-main-comment-delete-summary">

               <a class="delete-comment-info-link" data-remote="true"
                 rel="nofollow" data-method="DELETE" href="/comment/${value.id}">
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

         <ul class="index-main-comment-btns">
           <a class="comment-fa-edit-link">
             <i class="fas fa-edit fa-2x"></i>
           </a>

           <a class="comment-edit-btn-link">
             <div class="comment-edit-btn">編集</div>
           </a>

           <a class="comment-delete-btn-link">
             <div class="comment-delete-btn">削除</div>
           </a>
       
         </ul>

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
                ${value.comment_goods_length}
              </div>
            </div>
          </div>
        </div>`
     )
    })


    }else{
      $.each(data, function (index, value) {
        $(delete_element).prepend(
 
   `<div class="index-main-contens-comment-content-name">コメント</div>
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
                ${value.comment_goods_length}
           </div>
            </div>
      </div>`
      )
    })

    location.reload();
    
    }
    })

    .fail(function (data) {
      return false;
    })
  });
});
