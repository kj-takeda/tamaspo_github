  
$(function() {
  $('.search-train-input').on('input', function(e){
    var input = $(".search-train-input").val();

     $.ajax({
      type: 'GET',
      url: '/places/search',
      data: { keyword: input },
      dataType: 'json'
     })
  
     .done(function(data01){

      $('.line_trains-info-flame-inner').empty()
      
      $.each(data01 , function(index, value) {
    
        $('.line_trains-info-flame-inner').append(`<a href="${value.train_id}" value="${value.train_name}" 
        id="${value.line_name}" class="link-train"><div class="train-info">${value.train_name} / ${value.line_name}</div></a>`);
      });

    //表示された駅名リンクをクリックすると
    $(".link-train").on('click',function(e){
    e.preventDefault();

    //駅名/沿線リンクに紐づけている駅名・駅id・沿線名を取得
    var train_name = $(this).attr('value');
    var line_name = $(this).attr('id');
    var train_id = $(this).attr('href');

    train_name += " / "
    train_name += line_name

    $("#train_id option").val(train_id).text(train_name);
    $("#place_train_id option").val(train_id).text(train_name);
    console.log(train_id);
    console.log(train_name);
    console.log(line_name);

    $(".search-train-input").val(null);

    $('.line_trains-info-flame-inner').empty()
    
  });


    })  

    .fail(function(data01){
      alert('エラーが発生したためメッセージは送信できませんでした。');
    })

  });
});








