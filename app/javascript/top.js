$(function(){

$(document).on('turbolinks:load', function() {

//topページ ジャンルボタンをクリックすると
//ジャンル検索のモーダルウィンドウが出る
$(".top-button-genre").on('click',function(e){
  e.preventDefault();
  $('.top-modal-genre').show();
});

//topページ エリアボタンをクリックすると
//エリア検索のモーダルウィンドウが出る
$(".top-button-area").on('click',function(e){
  e.preventDefault();
  $('.top-modal-area').show();
});

//モーダルウィンドウの検索チェックボタンにチェックがなければ
//エラーテキストが表示されてビジュアルが変化してデータ送信不可
$('.check-submit').click(function(){
//フォームのチェック数をカウント
  var check_count = $('.top-modal-form :checked').length;

  if (check_count == 0 ){
  
  //背景を白っぽく
  $('.top-modal-flame').css('background-color', "rgba(230, 230, 230, 0.500)");
  //選択肢の背景をレッドに
  $('.top-modal-flame-inner-form ').css('background-color', "red");
  //上部エラーメッセージを表示する
  $('.top-modal-flame-inner-err').show()
  return false;

  } 
});

$('.top-modal-flame-cancel-link').click(function(){
  
  $('.top-modal').hide();
  });


});
});
