$(function(){

  //メールアドレス検索をクリック
  $('.edit-password-actions').on('click', function(){
    //メアドを取得
    var email = $(".edit-password-email-input").val();
    //メアドに全角などが含まれていれば
    if(email == ""){
      alert("メールアドレスを入力してください")
      return false;
     }
  });

  //パスワード更新をクリック
  $('.edit-password-actions2').on('click', function(){
   //パスワードを取得
   var edit_password = $(".edit-password-input").val();
   //もしパスワードが空白であれば
   if(edit_password == ""){
     alert("パスワードを入力してください")
     return false;
    }
   //もし半角英数字以外が含まれていれば
    if(!(edit_password.match(/^[0-9]*$/))){
     alert("パスワードに半角英数字以外の文字が含まれています")
     return false;
   }
  });


});
