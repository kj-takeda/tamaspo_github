$(function () {
  //イベントのペンマークをクリック
  //無限スクロール対応
  $(document).on('click' , '.match-fa-edit-link',
  function() {
  //削除ボタンが表示非表示を繰り返す
  $(this).next(".match-delete-btn-link").children(".match-delete-btn").toggle();
  });

  $(document).on('click' , '.match-delete-btn-link',
  function() {
    //イベント削除モーダルが表示される
    $(this).parent().prev(".delete-match-info").show();
    });

    //イベント削除ボタンをクリックして削除モーダル消す
    $(document).on('click' , '.delete-match-info-link',
  function() {
    //イベント削除モーダルが表示される
    $(this).parent().parent().parent().hide();
    });

    //イベント・キャンセルボタンをクリックして削除モーダル消す
    $(document).on('click' , '.delete-match-info-cancel-link',
  function() {
    //イベント削除モーダルが表示される
    $(this).parent().parent().parent().hide();
    });

});
