# db/seeds.rb

User.delete_all
User.create!(nickname: 'testuser1', email: 'test_user1@test.com', encrypted_password: '$2a$12$v7VrWBScRrk9xhKRGSIUquIHmWMwPzK78E3R0n8PqXR6PoJSGrspG', group_id: 2)
User.create!(nickname: 'testuser2', email: 'test_user2@test.com', encrypted_password: '$2a$12$2FGo8UU33TM9XzenS68PNubmEWW3t7QgAIjS6CfNppMaAlPgHx4fe', group_id: 2)
User.create!(nickname: 'testuser3', email: 'test_user3@test.com', encrypted_password: '$2a$12$x/NHToGrWzOwjW2qKVxKm.t.rZeouPAuZyc72CMI2C0..7pYtkYuG', group_id: 2)
User.create!(nickname: 'testuser4', email: 'test_user4@test.com', encrypted_password: '$2a$12$Rso0x0zxkb/aY9kkaF0TXe/3JG/Yqd7oBekUeCB2Ud190Q/cH3xOO', group_id: 3)
User.create!(nickname: 'testuser5', email: 'test_user5@test.com', encrypted_password: '$2a$12$8pmLSX48/zXywk8KeSnnPexR/n7jG2iY9U3o.ThLuX79RhGhxI5lO', group_id: 3)
Tag.delete_all
Tag.create!(tag_name: 'ruby', color_code: 8)
Tag.create!(tag_name: 'Gem', color_code: 10)
Tag.create!(tag_name: 'html', color_code: 10)
Tag.create!(tag_name: 'css', color_code: 7)
Tag.create!(tag_name: '設計', color_code: 6)
Tag.create!(tag_name: 'Git hub', color_code: 6)
Tag.create!(tag_name: 'Test', color_code: 5)
Tag.create!(tag_name: 'Linux', color_code: 1)
Tag.create!(tag_name: 'scss', color_code: 4)
Tag.create!(tag_name: 'like', color_code: 2)
Tag.create!(tag_name: 'japan', color_code: 6)
Tag.create!(tag_name: 'js', color_code: 9)
Tag.create!(tag_name: 'AIモデル', color_code: 4)
Tag.create!(tag_name: 'javascript', color_code: 9)
Tag.create!(tag_name: 'Windows', color_code: 3)
Tag.create!(tag_name: 'OS', color_code: 9)
Tag.create!(tag_name: '環境構築', color_code: 10)
Tag.create!(tag_name: '資料作成', color_code: 8)
Note.delete_all
Note.create!(user: User.find(1), title: 'Redcarpet実装に関して', content: '#### ヘルパーメソッド実装理由
* RailsアプリケーションでMarkdownをHTMLに変換するためのヘルパーメソッドを定義
* ヘルパーメソッドを使うことで、アプリケーション内の複数のビューで同じMarkdownの変換処理を共通化できる

##### options
* MarkdownをHTMLに変換する際の基本的な設定を指定
	* filter_html: HTMLタグをフィルタリングするかどうかを指定
	* hard_wrap: 改行をHTMLの改行タグ(\<br>)として保持するかどうかを指定

##### extensions
* Markdown処理に追加の機能や構文を提供するための拡張機能の設定
	* autolink: 自動的にURLやメールアドレスをリンクに変換する機能を有効にするかどうかを指定
	* uperscript: 上付き文字（例: x²）をサポートするかどうかを指定', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'rel, target属性について', content: '* rel属性: rel: 'nofollow'
	* リンクの関係性を示す nofollowは、検索エンジンのクローラーに対してリンクをたどらないように指示するための属性
	* リンクを経由したページへのSEO効果が減少する
&nbsp;
&nbsp;
* target属性: target: "\_blank"
	* リンクを開く際のターゲットウィンドウを指定
	* \_blankを指定すると、リンクを新しいタブやウィンドウで開く', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'GithubのソースをVSCodeのようにして見る方法', content: '* Git hubにアクセスしてURLを変更するだけでVSCodeのようにソースコードを見ることができる
	* やり方
	* 例)**1s**をつけるだけ
		* github.com/oivoodoo/devisemasquerade
		* github**1s**.com/oivoodoo/devise_masquerade
		
', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'Ruby on Railsとは', content: '#### Ruby on Railsの特徴
* 設計ルールが決まっている為シンプルに記述できる
* 開発補助ツールが豊富
* 日本語の参考文献が豊富

##### rails new コマンド
* 新規アプリケーションを作成する際に使用する
	* バージョンを指定する場合
		* rails \_7.0.0_ new アプリケーション名
	* オプションをつける場合
		* rails \_7.0.0_ new アプリケーション名 -オプション名
	* 例 rails \_7.0.0_ new test_app -d mysql

##### rails db:create コマンド
* データベースを作成する

##### rails db:drop コマンド
* データベースを削除する', category_id: 2, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'text_areaに入力した改行を反映させて表示', content: '#### 入力
* form_withヘルパーを使用してテキストエリア入力欄を作成

```ruby
<%= form_with model: current_user, local: true do |f|%>
	<div class='field-input'>
		<%= f.text_area :profile %>
	</div>
<% end %>
```

#### ユーザー操作
　ユーザーがテキストエリア内でエンターを押して
　改行して文章を入力する

#### 出力
* 表示させたい箇所でsimple_formatメソッドを使用してあげるとエンターでの改行を\<br>タグに変換して表示してくれる

```ruby
<%= simple_format(current_user.profile) %>
```
', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'モデル、ヘルパー、サービスの使い分け', content: 'コントローラーにメソッドが多くなり肥大化する場合、それらをコントローラーから分離することは一般的に推奨されている。

##### モデル
* ビジネスロジックがデータに密接に関連している場合や、データベースの操作やデータのバリデーションを含む場合に適している。
* 単純にデータの集計や算術操作を行う場合には過剰。

##### ヘルパー
* ビューのヘルパーメソッドを追加してビューの整形を支援する場合に適している。
* ビジネスロジックが含まれる場合には適さないことがある。

##### サービス
* ビジネスロジックやデータ操作を集約するのに最適な場所。
* コントローラーで使用する複数のメソッドをひとまとめにして、より再利用可能な形で管理することができる。', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'cssとscssの違いについて', content: '#### CSS (Cascading Style Sheets)
* 基本的なスタイルシート言語：HTML要素のスタイルを指定するための言語。
* シンプルな構文：CSSはシンプルで、セレクタとプロパティのペアでスタイルを指定。

```css
body {
  background-color: #f0f0f0;
}

h1 {
  color: #333;
  font-size: 24px;
}
```

#### SCSS (Sassy CSS)
* CSSのスーパーセット：SCSSはCSSにいくつかの拡張機能を追加したもの。
	* ネスト：SCSSではセレクタをネストすることができる。
	* 変数：SCSSでは変数を使用して色、フォントサイズ、その他のCSSプロパティを管理できる。
	* ミックスイン：再利用可能なコードブロックを定義できる。
	* 継承：他のスタイルからプロパティを継承できる。

```scss
$primary-color: #333;
$background-color: #f0f0f0;

body {
  background-color: $background-color;
}

h1 {
  color: $primary-color;
  font-size: 24px;

  &:hover {
    color: lighten($primary-color, 20%);
  }
}
```

##### ミックスインとは
* よく利用するCSSのスタイルを定義して、他の場所でも使いまわせるようにする機能。
* 関数のようにも扱える。
* @mixinを使用する。

```scss
@mixin bordered-box($border-color: #ccc, $border-width: 1px) {
  border: $border-width solid $border-color;
  padding: 10px;
}

.box1 {
  @include bordered-box;
}

.box2 {
  @include bordered-box(#f00, 2px);
}
```

##### 継承とは
* スタイルを継承して再利用することができる。
* @extendを使用する。

```scss
// ベースとなるボタンのスタイル
.button-base {
  padding: 10px 20px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

// 特定のボタンに適用するスタイル
.primary-button {
  @extend .button-base;
  background-color: #007bff;
  color: #fff;
}
```
##### 使い分けポイント
* ミックスインはパラメータを使って柔軟にスタイルを生成する際に適している。
* 継承はスタイルの共通化と一貫性を保ちたい場合に適している。', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(3), title: '容量確認_ChatGPT返答', content: '### Linuxでフォルダ容量を特定して削除するプロセス

1. **ディスク使用量の確認**
   まず、`df`コマンドを使ってディスク全体の使用状況を確認します。
	 
	 ```bash
   df -h
	 ```
	 コマンド結果の例:
	 ```bash
	 Filesystem      Size  Used Avail Use% Mounted on
	 /dev/sda1       100G   85G   15G  86% /
	 /dev/sda2       200G   50G  150G  25% /home
	 ```

2. **容量を圧迫しているフォルダの特定**
   次に、duコマンドを使用して各フォルダの容量を調べます。ルートディレクトリから開始し、
   どのフォルダが容量   を多く使っているかを特定します。
	 
	 ```bash
   sudo du -sh /*
	 ```
	 コマンド結果の例:
	 ```bash
	 12G   /home
	 40G   /var
	 5G    /usr
	 1G    /opt
	 300M  /tmp
	 100M  /etc
	 50M   /boot
	 ```
	 この結果から、/varフォルダが最も容量を使っていることがわかります。

3. **詳細な使用状況の確認**
   /varフォルダ内でどのサブフォルダが容量を多く使っているかを特定します。
	 
	 ```bash
   sudo du -sh /var/*
	 ```
	 コマンド結果の例:
	 ```bash
   30G   /var/log
   5G    /var/lib
   3G    /var/cache
   1G    /var/spool
   500M  /var/tmp
	 ```
	 この結果から、/var/logフォルダが容量を圧迫していることがわかります。

4. **容量を圧迫しているファイルの特定**
   lsコマンドを使用して、/var/logフォルダ内で大きなファイルを特定します。
	 
	 ```bash
   sudo ls -lh /var/log
	 ```
	 コマンド結果の例:
	 ```bash
   -rw-r--r-- 1 root root  20G Jan  1 00:00 syslog
   -rw-r--r-- 1 root root  8G  Jan  1 00:00 kern.log
   -rw-r--r-- 1 root root  2G  Jan  1 00:00 auth.log
   -rw-r--r-- 1 root root  500M Jan  1 00:00 daemon.log
	 ```
	 この結果から、syslogとkern.logが非常に大きいことがわかります。

5. **ログファイルの削除**
   必要に応じて、これらの大きなログファイルを削除します。
	 削除する前に、バックアップを取ることをお勧めします。
	 
	 ```bash
   sudo rm /var/log/syslog
	 sudo rm /var/log/kern.log
	 ```

6. **削除後のディスク使用量の確認**
   最後に、再度ディスク使用量を確認して、削除が成功したことを確認します。
	 
	 ```bash
   df -h
	 ```
	 コマンド結果の例:
	 ```bash
   Filesystem      Size  Used Avail Use% Mounted on
   /dev/sda1       100G   57G   43G  57% /
   /dev/sda2       200G   50G  150G  25% /home
	 ```
	 /dev/sda1の使用量が減少していることが確認できます。', category_id: 12, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'Claude 3.5 Sonnet（クロード 3.5 ソネット）', content: '#### Claude 3.5 Sonnet （クロード 3.5 ソネット）とは
* 2024年6月に登場した最新のAIモデル
* Anthropicが開発
* 処理速度が2倍、コストが5分の1という驚異的な性能向上に加え、強化されたマルチモーダル能力と高度な推論力を備えている

#### Claude 3.5 SonnetとGPT4o・Geminiとの比較

| 評価軸  | 説明 | Claude 3.5 Sonnet | Claude 3 Opus | GPT-4o| Gemini 1.5 Pro |
| -------- | -------- | -------- | -------- | -------- | -------- |
| Visual math reasoning     | 視覚的な数学的推論能力の評価     | 67.7%     | 50.5%     | 63.8%     | 63.9%     |
| Science diagrams     | 科学的な図表の理解と解析能力の評価     | 94.7%     | 88.1%     | 94.2%     | 94.4%     |
| Visual question answering     | 視覚情報に基づく質問への回答能力の評価     | 68.3%     | 59.4%     | 69.1%     | 62.2%     |
| Chart Q&A     | グラフに基づく質問への回答能力の評価     | 90.8%     | 80.8%     | 85.7%     | 87.2%     |
| Document visual Q&A      | 文書内の視覚情報に基づく質問への回答能力の評価     | 95.2%      | 89.3%     | 92.8%     | 93.1%      |

#### Claude 3.5 Sonnetの料金
Claude 3.5 Sonnetは、ブラウザ・アプリ版共に無料で利用することが可能ですが、回数制限が設けられている。

#### Claude 3.5 Sonnet URL
https://www.anthropic.com/news/claude-3-5-sonnet
', category_id: 8, is_public: false, group_id: 2)
Note.create!(user: User.find(4), title: 'TEST', content: 'test', category_id: 6, is_public: true, group_id: 3)
Note.create!(user: User.find(2), title: 'プログラムの記述方法', content: '### 以下は全て同じ処理になる

###### do ... endを利用した記述
```ruby
@lists.select do |list|
  list.hoge?
end
```
do ... end は処理の中身が長いブロックに使われる

###### ブロックを利用した記述
```ruby
@lists.select { |list| list.hoge? }
```
中括弧 {} は処理の中身が短いブロックに使われる

###### シンタックスシュガーを利用した記述
```ruby
@lists.select(&:hoge?)
```
シンタックスシュガーはコードをより簡潔で読みやすくするために使われる
', category_id: 2, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'DB設計の指示_ChatGPT返答', content: '## Facebookを題材にしたデータベース設計

### users テーブル

| カラム名             | データ型        | 制約                                 | 
|---------------------|-----------------|--------------------------------------| 
| id                  | BIGINT          | PRIMARY KEY, AUTO_INCREMENT          | 
| username            | VARCHAR(50)     | NOT NULL, UNIQUE                     | 
| email               | VARCHAR(100)    | NOT NULL, UNIQUE                     | 
| encrypted_password  | VARCHAR(255)    | NOT NULL                             | 
| created_at          | TIMESTAMP       | NOT NULL, DEFAULT CURRENT_TIMESTAMP  | 
| updated_at          | TIMESTAMP       | NOT NULL, DEFAULT CURRENT_TIMESTAMP  | 

### posts テーブル

| カラム名             | データ型        | 制約                                 | 
|---------------------|-----------------|--------------------------------------| 
| id                  | BIGINT          | PRIMARY KEY, AUTO_INCREMENT          | 
| user_id             | BIGINT          | NOT NULL, FOREIGN KEY (users.id)    | 
| content             | TEXT            | NOT NULL                             | 
| created_at          | TIMESTAMP       | NOT NULL, DEFAULT CURRENT_TIMESTAMP  | 
| updated_at          | TIMESTAMP       | NOT NULL, DEFAULT CURRENT_TIMESTAMP  | ', category_id: 8, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'rails dbコマンドについて', content: '#### データベースの作成
```bush
rails db:create
```
#### データベースの削除
```bush
rails db:drop
```
#### マイグレーションファイルの実行
```bush
rails db:migrate
```
#### マイグレーションファイルの状態確認
```bush
rails db:migrate:status
```
#### マイグレーションファイルの状態を「down」にする
```bush
rails db:rollback
```

```bush
rails db:rollback STEP=n
```
```bush
$ rails db:rollback STEP=2
==省略==
$ rails db:migrate:status
 Status   Migration ID    Migration Name
--------------------------------------------------
  up     20191105052241  Devise create users
 down    20191106063303  Create groups     
 down    20191106063350  Create group users
 down    20191107034603  Create messages
```
STEP=2を指定すると現在の状態から+２つ分downにする

```bush
rails db:migrate:down VERSION=Migration ID
```
Migration IDを指定するとそのIDを持つマイグレーションの状態がdownになる
#### データベースの再作成
```bush
rails db:reset
```
新しくテーブルを作り直して、さらにシードファイルも読み込んでダミーデータも作る
rails db:drop → rails db:create → rails db:migrate → rails db:seed
```bush
rails db:migrate:reset
```
シードファイルは読み込まない
rails db:drop → rails db:create → rails db:migrate', category_id: 5, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: '投稿時刻の表示を日本時刻に変更する方法', content: '### 投稿時刻の表示を日本時刻に変更する方法
* 時刻の設定は、Railsのapplication.rbという設定ファイルに以下を追記する

```ruby
module ChatApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0 
    config.i18n.default_locale = :ja  # アプリケーションのデフォルトのロケールを日本語 (:ja) に設定
    config.time_zone = 'Tokyo'        # アプリケーションのデフォルトのタイムゾーンを「東京」（日本標準時）に設定
		# 中略
```

* ja.ymlファイルを作成
	* 表示フォーマットを設定している。以下の場合「20xx年x月x日 00:00:00」表記になる。

```yml
ja:
  time:
    formats:
      default: "%Y/%m/%d %H:%M:%S"
```

* lメソッドを利用して反映
	* 以下のような記述をすることで反映される

```ruby
<%= l hoge.created_at %>
```', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'Javascriptロードイベントについて', content: '## ロードの種類と用途

```javascript
document.addEventListener('DOMContentLoaded', () => {
  console.log('ページの内容が読み込まれました！');
  // ページが読み込まれた後に動かしたいコードを書く
});
```

#### DOMContentLoaded
- **タイミング**  
ウェブページの基本的な構造（HTML）が全部読み込まれて、ブラウザが解析を終えたときに起こる  
画像やCSSなどの重たいものが全部読み込まれるのを待たなくてもよい
- **使用目的**  
 ページの内容が表示されるようになったらすぐに動かしたいスクリプトがあるとき

#### load
- **タイミング**  
ページのすべての部分（HTML、画像、CSSなど全部）が完全に読み込まれたときに起こる
- **使用目的**  
ページのすべてのものが表示された後に動かしたいスクリプトがあるとき

#### turbo:load
- **タイミング**  
Turboというツールを使っているときに、ページの内容が変わったときに起こる  
普通のページ読み込みとは違い、部分的なページの更新があったときに起こる
- **使用目的**  
Turboを使っているアプリで、ページの内容が変わるたびに動かしたいスクリプトがあるとき

#### beforeunload
- **タイミング**  
ユーザーがページを離れようとするときに起こる
- **使用目的**  
ユーザーがページを離れる前に何かを確認したいとき  
例えば、入力中のフォームがあるときに「本当にページを離れていいですか？」と聞くなど

#### unload
- **タイミング**  
ページを離れた直後に起こる
- **使用目的**  
ページを離れた後に何かを実行したいときに使う  
例えば、ユーザーの行動を追跡するときなど', category_id: 2, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'WindowsOSバージョン調べ方', content: '1. windowsボタンを押す
2. 「winver」と入力しenterキーを押す
3. windows OSのバージョンとビルド番号を確認
「Windowsのバージョン情報」が表示される為確認', category_id: 12, is_public: true, group_id: 2)
Note.create!(user: User.find(1), title: 'WSL有効化', content: '#### 想定バージョン
Windows10、もしくはWindows11

#### WindowsOSバージョン調べ方
[こちらを参考](http://localhost:3000/notes/46)

#### WSL有効化手順
１．Windows + X → A の順に押下してPower Shellを起動
２．以下コマンドをPower Shellに入力してEnter

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

３．処理が完了して再度コマンドを入力できる状態になったら、次のコマンドをPower Shellに入力してEnter

```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all
```

４．今すぐコンピューターを再起動しますか？（Y/N） と表示されるので、Y を押下

#### WSLの設定
１．次のコマンドをPower Shellに入力してWSLのバージョンを最新版にアップデート
```
wsl --update
```
２．次のコマンドをPower Shellに入力して最新版を既定のバージョンに指定
```
wsl --set-default-version 2
```
３．次のコマンドをPower Shellに入力してバージョンを指定できているか確認
```
wsl --status
```
４．次のコマンドをPower Shellに入力してMac用の操作を受け付けるためのシステム（以下Ubuntu）を起動
```
wsl --install Ubuntu
```
５．起動したUbuntuでユーザー名とパスワードを入力して Enter', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'ルーティングの設定', content: '#### ルーティングの記述方法
##### 基本的な記述

```ruby
Rails.application.routes.draw do
 HTTPメソッド 'URIパターン', to: 'コントローラー名#アクション名'
end
```
```ruby
Rails.application.routes.draw do
 get 'hoges', to: 'hoges#index'
end
```
上記はget 'hoges'と記述することも可能である。

##### resourcesメソッド
* 7つのアクション全てのルートをまとめて作成できる

```ruby
Rails.application.routes.draw do
  resources :hoges
end
```

| アクション |  説明　 | 
| -------- | -------- |
| index     | 　一覧表示ページを表示するリクエストに対応して動く 　    |
| new     | 　新規投稿ページを表示するリクエストに対応して動く　     |
| create     | 　データの投稿を行うリクエストに対応して動く　     |
| show     | 　個別詳細ページを表示するリクエストに対応して動く 　    |
| edit     | 　投稿編集ページを表示するリクエストに対応して動く　     |
| update     | 　データの編集を行うリクエストに対応して動く　     |
| destroy     | 　データの削除を行うリクエストに対応して動く 　    |
  
##### ルートパスの設定
```ruby
Rails.application.routes.draw do
  root 'hoges#index'
end
```

##### collectionとmember
* 生成されるルーティングのURLと実行されるコントローラーを任意にカスタムできる
* URLの指定先が、collectionは:idなし、memberが:idありの違いがある

```ruby
Rails.application.routes.draw do
  resources :hoges do
    collection do
      get 'fuga'
    end
  end
end
```

```ruby
Rails.application.routes.draw do
  resources :hoges do
    member do
      get 'fuga'
    end
  end
end
```

##### 生成したルートの確認
コマンド
```bush
rails routes
```

例
```bush
Prefix           Verb    URI                                 Pattern
search_hoge      GET    /hoges/search(.:format)       hoges#search
```', category_id: 3, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'リード文作成指示_ChatGPT返答', content: '```
以下のインプットからコンテンツを想像しリード文と説明文を考えてください。

#インプット
・マークダウン形式
・余計な機能は省いた設計
・シンプルな操作
・学習内容を整理
・memoはNoteとPromptの2種類から作成
・カテゴリーやタグで分類

#アウトプット
・リード文
・コンテンツ説明文
```

リード文:
シンプルで使いやすい学習整理ツール - 効果的に学習内容を管理し、知識を最大限に活用しましょう。

コンテンツ説明文:
このツールは、学習内容を効率的に整理するための直感的なインターフェースを提供します。マークダウン形式での入力に対応し、余計な機能を省いたシンプルな設計で操作も簡単です。メモは大きく分けてNoteとPromptの2種類から作成でき、カテゴリーやタグで細かく分類することができます。これにより、学習内容を体系的に整理し、必要な情報にすばやくアクセスすることが可能です。', category_id: 12, is_public: true, group_id: 2)
Note.create!(user: User.find(2), title: 'Ruby on Rails の基本理念', content: '### DRY(Don’t Repeat Yourself)
* 「同じ情報を繰り返し定義しない」
* 可読性の向上や、コード量を減らすことによりアプリケーションの動作が早くなる

### CoC(Convention Over Configuration)
* 「設定よりも規約を優先する」
* 「すでに定義されている処理を利用する」ことで開発スピードが上がり質も担保できることや、規約は開発者同士の共通認識であるため可読性が向上する



### Ruby on Railsのディレクトリ階層
| ディレクトリ名 | 説明 |
| -------- | -------- |
| app     | MVCに関するファイルなどを格納している、アプリケーションの主要ディレクトリ     |
| bin     | Binary Codeの略。コマンドなどで実行するファイルが格納されている     |
| config     | アプリケーションの設定関係のファイルが格納されている     |
| db     | データベースに関するファイルが格納されている     |
| lib     | libraryの略で、基本的なライブラリが格納されている     |
| log     | アプリケーションが動いている間の記録などのファイルが格納されている     |
| node_modules     | nodeのパッケージが格納されている     |
| public     | デフォルトで表示される画面の情報などが格納されている     |
| storage     | 画像などをアプリケーション自体に保存する際に使用するディレクトリ     |
| test     | アプリケーションのテストを行う際に使用するファイルを格納するディレクトリ     |
| tmp     | アプリケーションが起動している際の一時的な情報を格納するディレクトリ     |
| vendor     | ライブラリ(Gem)などをアプリケーション自体にインストールする際に使用するディレクトリ     |



', category_id: 3, is_public: true, group_id: 2)
Prompt.delete_all
Prompt.create!(user: User.find(2), title: '容量確認手順', content: 'あなたはLinux開発に精通したプロのITエンジニアです。
以下の\# {動作}を行うLinuxコマンドを教えてください。
また、コマンドを叩いて特定、削除するまでのプロセスをコマンド結果と共に記載してください。
コマンド結果の具体的な値などはダミーであなたが考えてください。

\# {動作}
どのフォルダが容量を圧迫しているのかを特定して削除する', category_id: 12, is_public: true, group_id: 2)
Prompt.create!(user: User.find(4), title: 'TEST', content: 'test', category_id: 3, is_public: false, group_id: 3)
Prompt.create!(user: User.find(1), title: 'DB設計の指示', content: '### DB設計について

1.世の中に存在しているWebサイトを題材にしてテーブル名とカラム名を教えてください
　どのWebサイトを題材にしたかも教えてください
2.上記のテーブルの制約についてカラム毎に教えてください
3.上記をマークダウン形式で文字としてコピーできるようにまとめてください', category_id: 5, is_public: true, group_id: 2)
Prompt.create!(user: User.find(2), title: 'リード文作成指示', content: '以下のインプットからコンテンツを想像しリード文と説明文を考えてください。

#インプット
{自由入力}

#アウトプット
・リード文
・コンテンツ説明文', category_id: 12, is_public: true, group_id: 2)
NoteTag.delete_all
NoteTag.create!(note: Note.find(1), tag: Tag.find(1))
NoteTag.create!(note: Note.find(1), tag: Tag.find(2))
NoteTag.create!(note: Note.find(2), tag: Tag.find(3))
NoteTag.create!(note: Note.find(2), tag: Tag.find(4))
NoteTag.create!(note: Note.find(5), tag: Tag.find(1))
NoteTag.create!(note: Note.find(8), tag: Tag.find(1))
NoteTag.create!(note: Note.find(6), tag: Tag.find(1))
NoteTag.create!(note: Note.find(9), tag: Tag.find(4))
NoteTag.create!(note: Note.find(9), tag: Tag.find(9))
NoteTag.create!(note: Note.find(34), tag: Tag.find(8))
NoteTag.create!(note: Note.find(3), tag: Tag.find(6))
NoteTag.create!(note: Note.find(37), tag: Tag.find(7))
NoteTag.create!(note: Note.find(40), tag: Tag.find(1))
NoteTag.create!(note: Note.find(42), tag: Tag.find(5))
NoteTag.create!(note: Note.find(43), tag: Tag.find(1))
NoteTag.create!(note: Note.find(44), tag: Tag.find(1))
NoteTag.create!(note: Note.find(45), tag: Tag.find(14))
NoteTag.create!(note: Note.find(46), tag: Tag.find(15))
NoteTag.create!(note: Note.find(46), tag: Tag.find(16))
NoteTag.create!(note: Note.find(47), tag: Tag.find(17))
NoteTag.create!(note: Note.find(48), tag: Tag.find(1))
NoteTag.create!(note: Note.find(49), tag: Tag.find(18))
NoteTag.create!(note: Note.find(50), tag: Tag.find(1))
NoteTag.create!(note: Note.find(36), tag: Tag.find(13))
PromptTag.delete_all
PromptTag.create!(prompt: Prompt.find(2), tag: Tag.find(8))
PromptTag.create!(prompt: Prompt.find(3), tag: Tag.find(7))
PromptTag.create!(prompt: Prompt.find(6), tag: Tag.find(5))
PromptTag.create!(prompt: Prompt.find(7), tag: Tag.find(18))
Reference.delete_all
Reference.create!(referencable: Note.find(1), click_count: 3)
Reference.create!(referencable: Note.find(2), click_count: 2)
Reference.create!(referencable: Note.find(3), click_count: 17)
Reference.create!(referencable: Note.find(5), click_count: 3)
Reference.create!(referencable: Prompt.find(2), click_count: 9)
Reference.create!(referencable: Note.find(6), click_count: 7)
Reference.create!(referencable: Note.find(8), click_count: 6)
Reference.create!(referencable: Note.find(9), click_count: 8)
Reference.create!(referencable: Note.find(34), click_count: 1)
Reference.create!(referencable: Note.find(36), click_count: 0)
Reference.create!(referencable: Note.find(37), click_count: 0)
Reference.create!(referencable: Prompt.find(3), click_count: 0)
Reference.create!(referencable: Note.find(40), click_count: 0)
Reference.create!(referencable: Prompt.find(6), click_count: 0)
Reference.create!(referencable: Note.find(42), click_count: 0)
Reference.create!(referencable: Note.find(43), click_count: 1)
Reference.create!(referencable: Note.find(44), click_count: 0)
Reference.create!(referencable: Note.find(45), click_count: 0)
Reference.create!(referencable: Note.find(46), click_count: 0)
Reference.create!(referencable: Note.find(47), click_count: 0)
Reference.create!(referencable: Note.find(48), click_count: 0)
Reference.create!(referencable: Prompt.find(7), click_count: 0)
Reference.create!(referencable: Note.find(49), click_count: 0)
Reference.create!(referencable: Note.find(50), click_count: 0)
