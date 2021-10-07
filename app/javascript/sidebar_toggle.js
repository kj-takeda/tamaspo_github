$(function () {
  
  //documentと書くとテンプレートリテラルでもリンクをクリックできる
  $(document).on('click' , '.header-menu',
  function() {

  $(".index-main-sidebar").toggle();

  $(".user-show-main-sidebar").toggle();

  $(".user-search-main-sidebar").toggle();
  });

});
