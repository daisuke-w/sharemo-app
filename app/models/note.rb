class Note < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # エラーメッセージ定義
  error_message = "can't be blank"

  with_options presence: true do
    validates :category_id, numericality: { other_than: 1, message: error_message }
    validates :title
    validates :content
  end

  belongs_to :user
  belongs_to :prompt, optional: true
  belongs_to :category
end
