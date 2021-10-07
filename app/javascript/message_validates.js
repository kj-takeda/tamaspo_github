$(function(){
   //イベント名をカウントしてmax以上入力しようとすると文字カットここから
   $('.new_message').on('submit', function(e){  
     
    var message_body_input_val = $(".message-body-input").val();
    //入力可能max
    var message_body_count = 200;
    var message_body_input_count = message_body_input_val.length;
    //イベント名を50文字以上で入力するとアラーム&文字オーバー分をカット
    if(message_body_input_count > message_body_count){
      alert("200文字以内で入力してください")
      var showText = message_body_input_val.substring(0, match_name_count);
      $(this).val(showText);
      return false;
    }

    if(message_body_input_val == ""){
      alert("メッセージを入力してください")
      return false;
      }


  });
});
