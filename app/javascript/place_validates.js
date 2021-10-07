$(function(){
  //入力データをカウントしてmax以上入力しようとすると文字カットここから
  $('.place-name-input').on('keyup', function(e){  
    var place_name_input_val = $(".place-name-input").val();
    //入力可能max
    var name_count = 100;
    var place_name_input_count = place_name_input_val.length;
    //場所名を100文字以上で入力するとアラーム&文字オーバー分をカット
    if(place_name_input_count > name_count){
      alert("100文字以内で入力してください")
      var showText = place_name_input_val.substring(0, name_count);
      $(this).val(showText);
      return false;
    }
  });

  $('.place-tel-input').on('keyup', function(e){  
    var place_tel_input_val = $(".place-tel-input").val();
    //入力可能max
    var tel_count = 11;
    //TELデータの文字数を取得
    var place_tel_input_count = place_tel_input_val.length;
    //TELデータの文字数が11文字より大きければアラーム&文字オーバー分をカット
    if(place_tel_input_count > tel_count){
      alert("11文字以内で入力してください")
      var showText = place_tel_input_val.substring(0, tel_count);
      $(this).val(showText);
      return false;
    }
  });

  $('.place-address-input').on('keyup', function(e){  
    //住所データを取得
    var place_address_input_val = $(".place-address-input").val();
    //入力可能max
    var area_count = 100;
    //住所データの文字数を取得
    var place_address_input_count = place_address_input_val.length;
    
    //住所データの文字数が100文字より大きければアラーム&文字オーバー分をカット
    if(place_address_input_count > area_count){
      alert("100文字以内で入力してください")
      var showText = place_address_input_val.substring(0, area_count);
      $(this).val(showText);
      return false;
    }
  });

  $('.place-url-input').on('keyup', function(e){  
    var place_url_input_val = $(".place-url-input").val();
    //入力可能max
    var url_count = 300;
    //URLデータの文字数を取得
    var place_url_input_count = place_url_input_val.length;
    
    //URLの文字数が300文字より大きければアラーム&文字オーバー分をカット
    if(place_url_input_count > url_count){
      alert("300文字以内で入力してください")
      var showText = place_url_input_val.substring(0, url_count);
      $(this).val(showText);
      return false;
    }
  });

  $('.place-detail-input').on('keyup', function(e){ 
    var place_detail_input_val = $(".place-detail-input").val();
    //入力可能max
    var place_detail_count = 2000;
    //詳細情報の文字数を取得
    var place_detail_input_count = place_detail_input_val.length;
  
    //詳細情報の文字数が2000文字より大きければアラーム&文字オーバー分をカット
    if(place_detail_input_count > place_detail_count){
      alert("2000文字以内で入力してください")
      var showText = place_detail_input_val.substring(0, place_detail_count);
      $(this).val(showText);
      return false;
    }
  });
  

  //新規作成フォームを送信した時
  $('.place-new-form').on('submit', function(e){  
    //場所名に関するバリデjsここから----------------------------------------
    //場所名のデータを取得
    var place_name_input_val = $(".place-name-input").val();
    
    if(place_name_input_val == ""){
      alert("場所名を入力してください")
      return false;
    }
    //場所名に関sするバリデjsここまで----------------------------------------

    //TELに関するバリデjsここから------------------------------------------
    //TELデータを取得
    var place_tel_input_val = $(".place-tel-input").val();

    //TELデータが空白の場合はアラーム表示
    if(place_tel_input_val == ""){
      alert("TELを入力してください")
      return false;
    }
    
    //TELデータに半角数字以外のデータを含むとアラーム表示
    if(!place_tel_input_val.match(/^[0-9]+$/)){
      alert("TELは半角数値のみで入力してください")
      return false;
    }
    //TELに関するバリデjsここまで------------------------------------------

    //エリアに関するバリデjsここから----------------------------------------
    //選択エリアのテキストを取得
    var select_area_info = $('#place_area_id option:selected').text();
    //選択エリアのテキストが「エリアを選択してください」であれば
    //==該当エリアを選択していない場合にアラーム表示
    if(select_area_info == "エリアを選択してください"){
    alert("エリアを選択してください")
    return false
    }
    //エリアに関するバリデjsここまで----------------------------------------


    //住所に関するバリデjsここから----------------------------------------
    //住所データを取得
    var place_address_input_val = $(".place-address-input").val();

    //住所データが空白であればアラーム
    if(place_address_input_val == ""){
      alert("住所を入力してください")
      return false;
    }
    //住所に関するバリデjsここまで----------------------------------------


    //詳細情報に関するバリデjsここから----------------------------------------
    //詳細情報データを取得
    var place_detail_input_val = $(".place-detail-input").val();
    //詳細情報データが空白であればアラーム
    if(place_detail_input_val == ""){
      alert("詳細情報を入力してください")
      return false;
    }
    //詳細情報に関するバリデjsここまで----------------------------------------

    //ジャンルに関するバリデjsここから----------------------------------------
    //チェックしたジャンルidを格納する配列
    var genre_ids = []
    //ジャンルチェック済みジャンルvalue値を取得する
    $('input:checked').each(function() {
      var genre_id = $(this).val();
      genre_ids = genre_id
    })

    if(genre_ids == ""){
      alert("ジャンルを選択してください")
      return false;
    }
    //ジャンルに関するバリデjsここまで----------------------------------------

  
    //駅名に関するバリデjsここから----------------------------------------
    //駅名が空白の場合はアラーム表示 
   // var select_area_info = $('#place_train_id option:selected').text();
      if(select_area_info == ""){
        alert("駅名を選択してください")
      return false
    }
    //駅名に関するバリデjsここまで----------------------------------------
  });





  

  //編集作成フォームを送信した時
  $('.place-edit-form').on('submit', function(e){  
    //場所名に関するバリデjsここから----------------------------------------
    //場所名のデータを取得
    var place_name_input_val = $(".place-name-input").val();
    
    if(place_name_input_val == ""){
      alert("場所名を入力してください")
      return false;
    }
    //場所名に関するバリデjsここまで----------------------------------------

    //TELに関するバリデjsここから------------------------------------------
    //TELデータを取得
    var place_tel_input_val = $(".place-tel-input").val();

    //TELデータが空白の場合はアラーム表示
    if(place_tel_input_val == ""){
      alert("TELを入力してください")
      return false;
    }
    
    //TELデータに半角数字以外のデータを含むとアラーム表示
    if(!place_tel_input_val.match(/^[0-9]+$/)){
      alert("TELは半角数値のみで入力してください")
      return false;
    }
    //TELに関するバリデjsここまで------------------------------------------

    //エリアに関するバリデjsここから----------------------------------------
    //選択エリアのテキストを取得
    var select_area_info = $('#place_area_id option:selected').text();
    //選択エリアのテキストが「エリアを選択してください」であれば
    //==該当エリアを選択していない場合にアラーム表示
    if(select_area_info == "エリアを選択してください"){
    alert("エリアを選択してください")
    return false
    }
    //エリアに関するバリデjsここまで----------------------------------------

    //住所に関するバリデjsここから----------------------------------------
    //住所データを取得
    var place_address_input_val = $(".place-address-input").val();

    //住所データが空白であればアラーム
    if(place_address_input_val == ""){
      alert("住所を入力してください")
      return false;
    }
    //住所に関するバリデjsここまで----------------------------------------


    //詳細情報に関するバリデjsここから----------------------------------------
    //詳細情報データを取得
    var place_detail_input_val = $(".place-detail-input").val();
    //詳細情報データが空白であればアラーム
    if(place_detail_input_val == ""){
      alert("詳細情報を入力してください")
      return false;
    }
    //詳細情報に関するバリデjsここまで----------------------------------------

    //ジャンルに関するバリデjsここから----------------------------------------
    //チェックしたジャンルidを格納する配列
    var genre_ids = []
    //ジャンルチェック済みジャンルvalue値を取得する
    $('input:checked').each(function() {
      var genre_id = $(this).val();
      genre_ids = genre_id
    })

    if(genre_ids == ""){
      alert("ジャンルを選択してください")
      return false;
    }
    //ジャンルに関するバリデjsここまで----------------------------------------

  
    //駅名に関するバリデjsここから----------------------------------------
    //駅名が空白の場合はアラーム表示 
    var select_area_info = $('#place_train_id option:selected').text();
      if(select_area_info == ""){
        alert("駅名を選択してください")
      return false
    }
    //駅名に関するバリデjsここまで----------------------------------------
  });

});
