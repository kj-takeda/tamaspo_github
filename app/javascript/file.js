$(function(){
  $('.registration-image-input').on('change', function () {
    var file = $(this).prop('files')[0];
    $('.file-text').text(file.name);
});
});
