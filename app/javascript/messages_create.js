$(function () {
    
  $('.new_message').on('submit' , function() {
  
  body = $(this).children('.message-body-input').val();

  user_id = $(this).children('.message-user-id').children('.message-user-id-input').val();

  ele = $(this).parent().prev('.message-index-container').children('.message-main-contents')

  var message_body_input_val = $(".message-body-input").val();
    //入力可能max
    var message_body_count = 200;
    var message_body_input_count = message_body_input_val.length;
    //イベント名を50文字以上で入力するとアラーム&文字オーバー分をカット
    if(message_body_input_count > message_body_count){
      alert("200文字以内で入力してください")
      var showText = message_body_input_val.substring(0, message_body_count);
      $(".message-body-input").val(showText);
      return false;
    }

    if(message_body_input_val == ""){
      alert("メッセージを入力してください")
      return false;
      }

      $.ajax({
          type: 'post',
          url: '/messages' ,
          data: { user_id: user_id , body: body},
          dataType: 'json'
        })

        .done(function (data) {         
          //フォームに入力した内容を非同期でコメント欄に表示
          //コメントを作る最新コメント2件表示になる
          $.each(data, function (index, value) {
           $(ele).append(
     `<img src=${value.message_current_image.url}>
      <div class="message-main-content current-element">
        <p class="current-user-message">${value.body}</p>
      </div>
      <p class="current-user-name">${value.message_current_name}のメッセージ</p>
      <div class="messages-time">${value.message_created }</div>`)
       })
    })
  
    //safariのみajaxできないので苦肉の策
    .fail(function (data) {
     // location.reload();
      return false;
    })
      $('html, body').animate({
        scrollTop: $(document).height()
      },5000);
  });
});
