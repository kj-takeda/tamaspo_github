$(function () {
  //ユーザー情報を削除ボタンクリック
  $(document).on('click' , '.current_user_delete_link',
  function() {
    //ユーザー削除モーダルが表示非表示を繰り返す
    $(".delete-user-info").toggle();
    $(".edit-user-info").hide();
  });

  $(document).on('click' , '.delete-user-info-cancel-link',
  function() {
    //ユーザー削除モーダルが表示非表示を繰り返す
    $(".delete-user-info").hide();
  });

  //ユーザー情報を編集ボタンクリック
  $(document).on('click' , '.current_user_edit_link',
  function() {
    //ユーザー削除モーダルが表示非表示を繰り返す
    $(".edit-user-info").toggle();
    $(".delete-user-info").hide();
  });

  $(document).on('click' , '.edit-user-info-cancel-link',
  function() {
    //ユーザー削除モーダルが表示非表示を繰り返す
    $(".edit-user-info").hide();
  });




});
