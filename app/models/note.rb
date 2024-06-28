class Note < ApplicationRecord
  # エラーメッセージ定義
  error_message = "can't be blank"

  with_options presence: true do
    validates :category_id,       numericality: { other_than: 1, message: error_message }
    validates :title
    validates :content
    validates :is_public
  end

  belongs_to :user
  has_many   :prompts
end
