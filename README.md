# アプリケーション名
SHAREMO

# アプリケーション概要
Memoを整理して仲間内で共有できるアプリケーションです。  
企業内での利用を想定してグループ機能をつけています。

# アプリケーションを作成した背景
日頃から学習した内容や会話型AIでの質問や回答内容を整理したいと感じていました。  
また、他人が得た知見や知識を共有することで学習効率が上がると考えています。  
しかし、NotionやEvernoteなどのツールは機能が多く初学者が使いこなすのにはハードルが高いと感じました。  
そこで、本アプリケーションを作成しました。

# URL
https://sharemo-app.onrender.com

# テスト用アカウント
- Basic認証ID :admin
- Basic認証PW :3939
- テストユーザー1
  - Email：test_user1@test.com
  - PW：testuser1
  - group：TestGroup A
  - Email：test_user2@test.com
  - PW：testuser2
  - group：TestGroup A
  - Email：test_user3@test.com
  - PW：testuser3
  - group：TestGroup B

# 利用方法
### ユーザー登録・ログイン・ログアウト
![sign_up](https://github.com/user-attachments/assets/8c675ccf-8c42-4750-8c0c-d4ad5bfe84f6)
### Noteの作成
![new_note](https://github.com/user-attachments/assets/b3c4236a-4b34-4855-8f91-6b12cd0f347f)
### Promptの作成
![new_prompt](https://github.com/user-attachments/assets/a3527af4-62ec-4851-8730-144cd7118ddb)
### Promptに紐づくNoteの作成
![new_note_from_prompt](https://github.com/user-attachments/assets/1849c0bd-0b26-4efd-a802-6ff33c0d38d3)

# UIデザイン
[![Image from Gyazo](https://i.gyazo.com/8f3526d23c70e4c4456ace9ed566dbde.png)](https://gyazo.com/8f3526d23c70e4c4456ace9ed566dbde)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/a793a924006a5e6f62365a781327ad88.png)](https://gyazo.com/a793a924006a5e6f62365a781327ad88)

# 洗い出した要件
https://docs.google.com/spreadsheets/d/1DttmsgOMtc3hFzurpudnPFK2eH6DfNup8ubPt4TLFjg/edit?usp=sharing

# 機能一覧
[![Image from Gyazo](https://i.gyazo.com/0840ae81d287c79a140913c58b4bfecd.png)](https://gyazo.com/0840ae81d287c79a140913c58b4bfecd)

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
- フロントエンド
  - HTML, CSS, JavaScript
- バックエンド
  - Ruby on Rails
- テキストエディタ
  - Visual Studio Code
- タスク管理
  - Github

# 実装予定の機能
- ノートの保存機能
- 開発途中で気になった点の改修  
  https://github.com/daisuke-w/sharemo-app/issues
- 企業内で利用する場合は組織図等と紐づけて認証を行う機能  
  - 現在はymlファイルにグループを記述している
- ユーザー管理機能
  - 管理者は不要ユーザーを削除できる機能
  - 管理者はMemoの所有権を変更できる機能
