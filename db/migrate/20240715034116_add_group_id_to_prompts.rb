class AddGroupIdToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :group_id, :integer, null: false
  end
end
