class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # エラーメッセージ定義
  error_message = "can't be blank"

  with_options presence: true do
    validates :category_id, numericality: { other_than: 1, message: error_message }
    validates :title
    validates :content
  end

  belongs_to :user
  has_many   :note
  belongs_to :category

  # is_publicカラムが1の場合に true を返す
  def public?
    is_public
  end
end
