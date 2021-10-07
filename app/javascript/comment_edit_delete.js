$(function () {
  
  //documentと書くとテンプレートリテラルでもリンクをクリックできる
  $(document).on('click' , '.comment-fa-edit-link',
  function() {
  //編集・削除ボタンが表示非表示を繰り返す
  $(this).next('.comment-edit-btn-link').children('.comment-edit-btn').toggle();
  $(this).next('.comment-edit-btn-link').next('.comment-delete-btn-link').children('.comment-delete-btn').toggle();
  });

  //削除ボタンを押した時
  $(document).on('click' , '.comment-delete-btn',
  function() {
    //モーダル表示される
    $(this).parent().parent().prev(".edit-comment-info").prev(".delete-comment-info").show();
    });   

  //コメント削除ボタンを押したとき
  $(document).on('click' , '.delete-comment-info-link',
  function() {
      $(this).parent().parent().parent().hide();
    });


  //編集ボタンを押した時
  $(document).on('click' , '.comment-edit-btn',
  function() {
    //コメント編集モーダル表示される
    $(this).parent().parent().prev(".edit-comment-info").show();
    });   

  //コメント編集ボタンを押したとき
  $(document).on('click' , '.edit-comment-info-link',
  function() {
      $(this).parent().parent().parent().hide();
    });

  //コメント・キャンセルボタンを押したとき
  $(document).on('click' , '.delete-comment-info-cancel-link',
  function() {
      $(this).parent().parent().parent().hide();
    });

    //コメント・キャンセルボタンを押したとき
  $(document).on('click' , '.edit-comment-info-cancel-link',
  
  function() {
      $(this).parent().parent().parent().parent().hide();
    });

});
