$(function () {
  //イベントのペンマークをクリックすると
  //無限スクロール対応
  $(document).on('click' , '.place-fa-edit-link',
  function() {
    //削除ボタンが表示非表示を繰り返す
    $(this).next(".place-delete-btn-link").children(".place-delete-btn").toggle();
    //編集ボタンが表示非表示を繰り返す
    $(this).next(".place-delete-btn-link").next(".place-edit-btn-link").children(".place-edit-btn").toggle();
  });

  //削除ボタン関係ここから//////////////////////////////////////////////////
  //場所削除ボタンをクリックすると
  $(document).on('click' , '.place-delete-btn',
  function() {
    //場所削除モーダルが表示非表示を繰り返す
    $(this).parent().parent().prev('.delete-place-info').show();
  });

  //場所削除モーダルの削除ボタンをクリック
  $(document).on('click' , '.delete-place-info-link',
  function() {
    //場所削除モーダルが表示非表示を繰り返す
    $(this).parent().parent().parent().hide();
  });

  //場所削除モーダルのキャンセルボタンをクリック
  $(document).on('click' , '.delete-place-info-cancel-link',
  function() {
    //場所削除モーダルが表示非表示を繰り返す
    $(this).parent().parent().parent().hide();
  });

  //削除ボタン関係ここまで//////////////////////////////////////////////////
});
