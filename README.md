# オリジナルアプリ
#### リポジトリ名はアプリ名決定次第変更


# DB設計

## users テーブル

| Column             | LogicName        | Type       | Options                        |
| ------------------ | ---------------- | ---------- | ------------------------------ |
| nickname           | ニックネーム      | string     | null: false                    |
| email              | メールアドレス    | string     | null: false, unique: true      |
| encrypted_password | パスワード        | string     | null: false                    |
| profile            | プロフィール      | text       |                                |

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
| is_public   | 公開設定      | boolean    | null: false, default: false    |

### Association

- belongs_to :user
- has_many :prompts
- has_many :note_tags
- has_many :tags, through: :note_tags


## tags テーブル

| Column     | LogicName    | Type       | Options                        |
| ---------- | ------------ | ---------- | ------------------------------ |
| name       | タグ名       | string     | null: false                    |


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
| prompt      | プロンプト    | text       | null: false                    |
| is_public   | 公開設定      | boolean    | null: false, default: false    |


### Association

- belongs_to :user
- belongs_to :note
- has_many :prompt_tags
- has_many :tags, through: :prompt_tags

## prompt_tags テーブル (中間テーブル)

| Column     | LogicName    | Type       | Options                        |
| ---------- | ------------ | ---------- | ------------------------------ |
| prompt     | プロンプトID  | references | null: false, foreign_key: true |
| tag        | タグID       | references | null: false, foreign_key: true |

### Association

- belongs_to :note
- belongs_to :tag
