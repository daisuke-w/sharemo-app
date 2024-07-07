class AddColorCodeAndRenameNameColumnToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :color_code, :integer
    rename_column :tags, :name, :tag_name
  end
end
