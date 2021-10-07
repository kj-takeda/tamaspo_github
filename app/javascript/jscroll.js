$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    // 無限に追加する要素は、どこに入れる？
    contentSelector: '.jscroll', 
    // 次のページにいくためのリンクの場所は？ ＞aタグの指定
    nextSelector: '.next a',
    // 読み込み中の表示はどうする？
    loadingHtml: '<div class="page_css">読み込み中</div>'
  });
});
