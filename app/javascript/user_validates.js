$(function () {

  //ユーザー登録を送信
  $('.registration-new-form').on('submit', function () {

    //ユーザーネームを取得
    var name = $(".registration-name-input").val();
    //メアドに全角などが含まれていれば
    if (name == "") {
      alert("ユーザーネームを入力してください")
      return false;
    }

    //メアドを取得
    var email = $(".registration-email-input").val();
    //メアドに全角などが含まれていれば
    if (email == "") {
      alert("メールアドレスを入力してください")
      return false;
    }

    //ラジオボタンのチェックを取得
    var select_genre = $("input[name='user[genre_id]']:checked").val();
    //チェックが「undefined」の時=何もチェックしていない時アラームヒュ時
    if (select_genre == undefined) {

      alert("ジャンル名を選択してください")
      return false;
    }

    //パスワードを取得
    var registration_password = $(".registration-password-input").val();
   
    if (registration_password == "") {
      alert("パスワードを入力してください")
      return false;
    }
    //もし半角英数字以外が含まれていれば
    if (!(registration_password.match(/^[0-9]*$/))) {
      alert("パスワードに半角英数字以外の文字が含まれています")
      return false;
    }
  });


  //ユーザー編集を送信
  $('.registration-edit-form').on('submit', function () {
    //ユーザーネームを取得
    var name = $(".registration-name-input").val();
    //メアドに全角などが含まれていれば
    if (name == "") {
      alert("ユーザーネームを入力してください")
      return false;
    }

    //メアドを取得
    var email = $(".registration-email-input").val();
    //メアドに全角などが含まれていれば
    if (email == "") {
      alert("メールアドレスを入力してください")
      return false;
    }

    //ラジオボタンのチェックを取得
    var select_genre = $("input[name='user[genre_id]']:checked").val();

    if (select_genre == undefined) {
      alert("ジャンル名を選択してください")
      return false;
    }
    //パスワードを取得
    var registration_password = $(".registration-password-input").val();
    //もしパスワードが空白であれば
    if (registration_password == "") {
      alert("パスワードを入力してください")
      return false;
    }
    //もし半角英数字以外が含まれていれば
    if (!(registration_password.match(/^[0-9]*$/))) {
      alert("パスワードに半角英数字以外の文字が含まれています")
      return false;
    }
  });
});
