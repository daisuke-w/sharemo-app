class NoteForm
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :prompt_id,
    :category_id,
    :title,
    :content,
    :is_public,
    :id,
    :created_at,
    :updated_at,
    :name
  )


  # エラーメッセージ定義
  error_message = "can't be blank"

  with_options presence: true do
    validates :category_id, numericality: { other_than: 1, message: error_message }
    validates :title
    validates :content
  end

  # is_publicカラムが1の場合に true を返す
  def public?
    is_public
  end

  def save
    return unless name.present?

    ActiveRecord::Base.transaction do
      note = Note.create(user_id:, title:, content:, category_id:, is_public:)

      names = name.split(',').map(&:strip)
      names.each do |name|
        tag = Tag.where(name:).first_or_initialize
        tag.save
        NoteTag.create(note_id: note.id, tag_id: tag.id)
      end
      Reference.create(referencable: note)
    end
  end

  def update(params, note)
    ActiveRecord::Base.transaction do
      # 一度タグの紐付けを消す
      note.note_tags.destroy_all
      # paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
      names = params.delete(:name)&.split(',')
      if names.present?
        names.each do |name|
          # タグが既に存在するか確認し、存在しなければ新規作成する
          tag = Tag.where(name: name.strip).first_or_create
          # タグを保存
          tag.save if name.present?
          NoteTag.create(note_id: note.id, tag_id: tag.id)
        end
      end
      note.update(params)
    end
  end
end
