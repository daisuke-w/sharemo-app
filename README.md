# オリジナルアプリ

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
| is_public   | 公開設定      | boolean    | default: false                 |

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
