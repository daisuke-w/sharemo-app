class AddNotNullConstraintToColorCodeInTags < ActiveRecord::Migration[7.0]
  def change
    # null: false 制約を追加
    change_column_null :tags, :color_code, false
  end
end
