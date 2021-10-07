  $(function () {
    $(document).on('click' , '.index-main-contens-entry-comment-count-link',
    function() {
    $(this).parent().next('div').toggle();
    return false;
  });

  //コメントするボタンを押せばコメント欄がshow/hideを繰り返す
  $(document).on('click' , '.index-main-contens-entry-comment-link',
    function() {
    $(this).parent().next('div').toggle();
    return false;
  });
  });
