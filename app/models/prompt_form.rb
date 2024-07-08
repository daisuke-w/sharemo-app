class PromptForm
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :category_id,
    :title,
    :content,
    :is_public,
    :id,
    :created_at,
    :updated_at,
    :tag_name,
    :color_code
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
    ActiveRecord::Base.transaction do
      prompt = Prompt.create(user_id:, title:, content:, category_id:, is_public:)

      if tag_name.present?
        tag_names = tag_name.split(',').map(&:strip)
        tag_names.each do |tag_name|
          tag = Tag.where(tag_name:).first_or_initialize
          tag.color_code ||= rand(1..10)
          tag.save
          PromptTag.create(prompt_id: prompt.id, tag_id: tag.id)
        end
      end

      Reference.create(referencable: prompt)
    end
  end

  def update(params, prompt)
    ActiveRecord::Base.transaction do
      # 一度タグの紐付けを消す
      prompt.prompt_tags.destroy_all

      # paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
      tag_names = params.delete(:tag_name)&.split(',')
      if tag_names.present?
        tag_names.each do |tag_name|
          # タグが既に存在するか確認し、存在しなければ新規作成する
          tag = Tag.where(tag_name: tag_name.strip).first_or_create
          tag.color_code ||= rand(1..10)
          # タグを保存
          tag.save if tag_name.present?
          PromptTag.create(prompt_id: prompt.id, tag_id: tag.id)
        end
      end
      prompt.update(params)
    end
  end
end
