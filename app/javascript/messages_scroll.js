$(function(){
  //メッセージ送信んページの場合はスクールを一番下にする
  if($('.message-main-contents').length){
  $(window).on('load' , function(){
      $('html, body').animate({
        scrollTop: $(document).height()
      },1500);
      return false;
  });
}else if ($('.message-main-content').length){
  $(window).on('load' , function(){
    $('html, body').animate({
      scrollTop: $(document).height()
    },1500);
    return false;
});
}
});
