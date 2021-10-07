$(function(){

  //ユーザー登録を送信
  $('.new_user').on('submit', function(){
    //メアドを取得
    var email = $(".sessions-email-input").val();
    //メアドに全角などが含まれていれば
    if(email == ""){
      alert("メールアドレスを入力してください")
      return false;
     }

    //パスワードを取得
    var registration_password = $(".sessions-password-input").val();
      //もしパスワードが空白であれば
      if(registration_password == ""){
        alert("パスワードを入力してください")
        return false;
       }
      //もし半角英数字以外が含まれていれば
       if(!(registration_password.match(/^[0-9]*$/))){
        alert("パスワードに半角英数字以外の文字が含まれています")
        return false;
      }
    });

});
