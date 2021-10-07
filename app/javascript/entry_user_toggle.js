$(function(){
//エントリーユーザーを見るをクリック
$(document).on('click' , '.entry-users-show',
function() {
  $(this).next('.entry-users-index').toggle();
});

//エントリーユーザーを見るをクリック
$(document).on('click' , '.entry-users-index-cancel',
function() {
  $(this).parent().hide();
});

});
