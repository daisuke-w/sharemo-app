class AddGroupIdToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :group_id, :integer, null: false
  end
end
