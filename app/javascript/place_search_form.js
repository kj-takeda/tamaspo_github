$(function () {
  $('.header-search').on('click', function(){
    $('.index-search-form').toggle();

    $("body,html").animate({scrollTop: 0}, 500);
        return false;

});
});
