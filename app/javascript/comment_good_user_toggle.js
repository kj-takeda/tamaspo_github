$(function(){
//エントリーユーザーを見るをクリック
$(document).on('click' , '.good-users-show',
function() {
  $(this).next('.good-users-index').toggle();
});

//エントリーユーザーを見るをクリック
$(document).on('click' , '.entry-users-index-cancel',
function() {
  $(this).parent().hide();
});

});
