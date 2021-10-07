$(function(){

  //イベント投稿を送信
  $('.new_comment').on('submit', function(){
    //コメントに関するバリデjsここから---------------
    //コメントbodyを取得
    var comment_body_input_val = $(".comment-body-input").val();

    //未入力であれば
    if(comment_body_input_val == ""){
      alert("コメントを入力してください")
      return false;
     }

    var comment_body_count = 200;
    var comment_body_input_count = comment_body_input_val.length;
    //場所名を100文字以上で入力するとアラーム&文字オーバー分をカット
    if(comment_body_input_count > comment_body_count){
      alert("200文字以内で入力してください")
      var showText = comment_body_input_val.substring(0, comment_body_count);
      $(".comment-body-input").val(showText);
      return false;
    }
    //コメントに関するバリデjsここまで---------------
    });

    
    $(".comment-body-input").keyup(function(){
      var comment_body = $(this).val();
      //入力フォームにデータが入れば送信ボタンでる
      if(comment_body){
        $(".comment-new-form-submit-btn").show();
      }else if(!comment_body){
        $(".comment-new-form-submit-btn").hide();
      }

      
    
    });



  });

