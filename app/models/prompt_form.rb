class PromptForm
  include ActiveModel::Model

  attr_accessor(
    :user_id, :category_id,
    :title, :content, :is_public,
    :id, :created_at, :updated_at
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
    Prompt.create(
      user_id: user_id,
      title: title, content: content,
      category_id: category_id, is_public: is_public
      )
  end

  def update(params, prompt)
    prompt.update(params)
  end
end
