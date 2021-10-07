// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

//jsファイルを読み込んでいる
require("comment_show_hide.js")

//コメントを非同期で作る
require("comments_create.js")
//コメントを非同期で編集
require("comments_edit.js")

//球技スポット登録の先の駅インクリ検索
require("incremental_search.js")

//バリデーション関係jsここから//////////////////////////////
require("place_validates.js")

//バリデーション関係jsここから//////////////////////////////

require("top.js")

//フラッシュメッセージ関係のjs
require("flash_message.js")

//新規ユーザー登録に関するバリデjs
require("user_validates.js")

//新規イベント投稿に関するバリデjs
require("match_validates.js")

//新規コメント投稿に関するバリデjs
require("comment_validates.js")

//無限スクロール関係
require("jquery.jscroll.min.js")
require("jscroll.js")

//match情報を編集・削除するボタン関係js
require("match_delete.js")

//comment情報を編集・削除するボタン関係js
require("comment_edit_delete.js")

//place情報を編集・削除するボタン関係js
require("place_edit_delete.js")

//user情報を編集・削除するボタン関係js
require("user_edit_delete.js")


//place検索フォームを表示・非表示にするjs
require("place_search_form.js")

//ユーザー画像を選択したらファイル名表示されるjs
require("file.js")

//メッセージ作成js
require("messages_create.js")

//メッセージページスクロールjs
require("messages_scroll.js")

//ログインバリデjs
require("sessions_validates.js")

//サイドバーtogglejs
require("sidebar_toggle.js")

//エントリーユーザー一覧togglejs
require("entry_user_toggle.js")

//いいねユーザー一覧togglejs
require("comment_good_user_toggle.js")

//パスワード再設定に関するバリデjs
require("password_validates.js")

//新着通知があれば更新するjs
require("update.js")

//= require jquery
//= require rails-ujs 
//= require turbolinks 
//=require_tree .
//= require jquery.remotipart
