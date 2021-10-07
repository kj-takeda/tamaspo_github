$(function(){
  $(function(){
    var notifications_id = $('.notifications-first-number').text();
  
    if(notifications_id != "") {
    setInterval(update, 10000);
    }
    //10000ミリ秒ごとにupdateという関数を実行する
  });

  function update(){ //この関数では以下のことを行う
    var notifications_id = $('.notifications-first-number').text();
    console.log(notifications_id)
    
    $.ajax({ //ajax通信で以下のことを行う
      type: 'post', //メソッドを指定
      url: '/update' , //urlは現在のページを指定
      data: { notifications_id: notifications_id},
      dataType: 'json' //データはjson形式
    })

    .done(function (data) {
      //新着通知が1件でもあれば自動更新
      if(data.length > 0){
        console.log(data)
        setTimeout(function () {
          location.reload();
      }, 2000);
      }
      return false;
    })
    .fail(function (data) {
      return false;
    })

  }
});
