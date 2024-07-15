# アプリケーション名
SHAREMO

# アプリケーション概要
Memoを整理して仲間内で共有できるアプリケーションです。  
企業内での利用を想定してグループ機能をつけています。

# アプリケーションを作成した背景
日頃から学習した内容や会話型AIでの質問や回答内容を整理したいと感じていました。  
また、他人が得た知見や知識を共有することで学習効率が上がると考えています。  
しかし、NotionやEvernoteなどのツールは機能が多く、初学者が使いこなすのにはハードルが高いと感じました。  
そこで、本アプリケーションを作成しました。

# URL
https://myapp-x863.onrender.com/

# テスト用アカウント
- Basic認証ID :admin
- Basic認証PW :3939
- テストユーザー1
  - Email：test_user1@test.com
  - PW：testuser1 
  - Email：test_user2@test.com
  - PW：testuser2 
  - Email：test_user3@test.com
  - PW：testuser3

# 利用方法
### ユーザー登録・ログイン・ログアウト
### Noteの作成
### Promptの作成
### Promptに紐づくNoteの作成

# UIデザイン
[![Image from Gyazo](https://i.gyazo.com/8f3526d23c70e4c4456ace9ed566dbde.png)](https://gyazo.com/8f3526d23c70e4c4456ace9ed566dbde)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/a793a924006a5e6f62365a781327ad88.png)](https://gyazo.com/a793a924006a5e6f62365a781327ad88)

# 洗い出した要件

# DB設計
## ER図
[![Image from Gyazo](https://i.gyazo.com/bfcade75ff7f37487378661a17c6566c.png)](https://gyazo.com/bfcade75ff7f37487378661a17c6566c)

## users テーブル

| Column             | LogicName        | Type       | Options                        |
| ------------------ | ---------------- | ---------- | ------------------------------ |
| nickname           | ニックネーム      | string     | null: false                    |
| email              | メールアドレス    | string     | null: false, unique: true      |
| encrypted_password | パスワード        | string     | null: false                    |
| profile            | プロフィール      | text       |                                |
| group_id           | グループID        | integer    | null: false                    |

### Association

- has_many :notes
- has_many :prompts

## notes テーブル

| Column      | LogicName    | Type       | Options                        |
| ----------- | ------------ | ---------- | ------------------------------ |
| user        | ユーザーID    | references | null: false, foreign_key: true |
| prompt      | プロンプトID  | references | foreign_key: true              |
| category_id | カテゴリーID  | integer    | null: false                    |
| title       | タイトル      | string     | null: false                    |
| content     | 内容         | text        | null: false                    |
| is_public   | 公開設定      | boolean    | default: false                 |
| group_id    | グループID    | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :prompt
- has_many :note_tags
- has_many :tags, through: :note_tags
- has_many :references, as: :referencable

## tags テーブル

| Column      | LogicName    | Type       | Options      |
| ----------- | ------------ | ---------- | ------------ |
| tag_name    | タグ名       | string     | unique: true |
| color_code  | カラーコード | integer    | null: false  |

### Association

- has_many :note_tags
- has_many :notes, through: :note_tags

## note_tags テーブル (中間テーブル)

| Column     | LogicName    | Type       | Options                        |
| ---------- | ------------ | ---------- | ------------------------------ |
| note       | ノートID     | references | null: false, foreign_key: true |
| tag        | タグID       | references | null: false, foreign_key: true |

### Association

- belongs_to :note
- belongs_to :tag

## prompts テーブル

| Column      | LogicName    | Type       | Options                        |
| ----------- | ------------ | ---------- | ------------------------------ |
| user        | ユーザーID    | references | null: false, foreign_key: true |
| category_id | カテゴリーID  | integer    | null: false                    |
| title       | タイトル      | string     | null: false                    |
| content     | 内容          | text       | null: false                    |
| is_public   | 公開設定      | boolean    | default: false                 |
| group_id    | グループID    | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :notes
- has_many :prompt_tags
- has_many :tags, through: :prompt_tags
- has_many :references, as: :referencable

## prompt_tags テーブル (中間テーブル)

| Column     | LogicName    | Type       | Options                        |
| ---------- | ------------ | ---------- | ------------------------------ |
| prompt     | プロンプトID | references | null: false, foreign_key: true |
| tag        | タグID       | references | null: false, foreign_key: true |

### Association

- belongs_to :note
- belongs_to :tag

## references テーブル

| Column            | LogicName      | Type      | Options      |
| ----------------- | -------------- | --------- | ------------ |
| referencable_id   | 参考ID         | integer    | null: false, index |
| referencable_type | Note or Prompt | string    | null: false  |
| click_count       | クリック数      | integer   | default: 0   |

### Association

- belongs_to :referencable, polymorphic: true

# 開発環境
### フロントエンド
HTML, CSS, JavaScript
### バックエンド
Ruby on Rails
### テキストエディタ
Visual Studio Code
### タスク管理
Github
