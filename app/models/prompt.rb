class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many   :notes
  belongs_to :category
  has_many   :prompt_tags, dependent: :destroy
  has_many   :tags, through: :prompt_tags
  has_one    :reference, as: :referencable, dependent: :destroy

  before_destroy :nullify_notes_prompt_id

  private

  # Prompt削除時に、Noteが紐づいている場合はidをnilにする
  def nullify_notes_prompt_id
    notes.update_all(prompt_id: nil)
  end
end
