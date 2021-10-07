$(function(){
   //イベント名をカウントしてmax以上入力しようとすると文字カットここから
   $('.match-name-input').on('keyup', function(e){  
    var match_name_input_val = $(".match-name-input").val();
    //入力可能max
    var match_name_count = 50;
    var match_name_input_count = match_name_input_val.length;
    //イベント名を50文字以上で入力するとアラーム&文字オーバー分をカット
    if(match_name_input_count > match_name_count){
      alert("50文字以内で入力してください")
      var showText = match_name_input_val.substring(0, match_name_count);
      $(this).val(showText);
      return false;
    }
  });

  //イベントの詳細をカウントしてmax以上入力しようとすると文字カットここから
  $('.match-event-detail-input').on('keyup', function(e){  
    var match_event_detail_val = $(".match-event-detail-input").val();
    //入力可能max
    var match_event_detail_count = 500;
    var match_event_detail_input_count = match_event_detail_val.length;
    //イベントの詳細を500文字以上で入力するとアラーム&文字オーバー分をカット
    if(match_event_detail_input_count > match_event_detail_count){
      alert("500文字以内で入力してください")
      var showText = match_event_detail_val.substring(0, match_event_detail_count);
      $(this).val(showText);
      return false;
    }
  });

  //開催場所の詳細をカウントしてmax以上入力しようとすると文字カットここから
  $('.match-area-detail-input').on('keyup', function(e){  
    var match_area_detail_val = $(".match-area-detail-input").val();
    //入力可能max
    var match_area_detail_count = 100;
    var match_area_detail_input_count = match_area_detail_val.length;
    //場所名を100文字以上で入力するとアラーム&文字オーバー分をカット
    if(match_area_detail_input_count > match_area_detail_count){
      alert("100文字以内で入力してください")
      var showText = match_area_detail_val.substring(0,match_area_detail_count);
      $(this).val(showText);
      return false;
    }
  });



  //イベント投稿を送信
  $('.match-new-form').on('submit', function(){
    //イベント名に関するバリデjsここから---------------
    //イベント名を取得
    var match_name_input_val = $(".match-name-input").val();
    //未入力であれば
    if(match_name_input_val == ""){
      alert("イベント名を入力してください")
      return false;
      }
    //イベント名に関するバリデjsここまで---------------

    //イベント詳細に関するバリデjsここから----------------------------------------
    //イベント詳細を取得
      var match_event_detail_val = $(".match-event-detail-input").val();
    //未入力であれば
      if(match_event_detail_val == ""){
      alert("イベント詳細を入力してください")
     return false;
    }

    
     //イベント詳細に関するバリデjsここまで----------------------------------------
    //日付を取得
    var match_day = $(".match-day-input").val();
    //未入力であれば
    if(match_day == ""){
      alert("開催日を入力してください")
      return false;
     }

     //開催時間を取得
    var match_time = $(".match-time-input").val();
    //未入力であれば
    if(match_time == ""){
     alert("開催時間を入力してください")
     return false;
     }

     //エリアに関するバリデjsここから----------------------------------------
    //選択エリアのテキストを取得
   var select_match_info = $('#match_area_id option:selected').text();
    //選択エリアのテキストが「エリアを選択してください」であれば
    //==該当エリアを選択していない場合にアラーム表示
   if(select_match_info == "エリアを選択してください"){
    alert("エリアを選択してください")
    return false
  }
    //エリアに関するバリデjsここまで----------------------------------------

     //開催場所を取得
    var match_area_detail = $(".match-area-detail-input").val();
    //未入力であれば
    if(match_area_detail == ""){
      alert("開催場所の詳細を入力してください")
      return false;
     }

     //ラジオボタンのチェックを取得
     var select_genre = $("input[name='match[genre_id]']:checked").val();
     //チェックが「undefined」の時=何もチェックしていない時アラームヒュ時
     if(select_genre == undefined){
       alert("ジャンルを選択してください")
       return false;
      }

    });
  });

