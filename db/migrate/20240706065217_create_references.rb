class CreateReferences < ActiveRecord::Migration[7.0]
  def change
    create_table :references do |t|
      t.integer :click_count, default: 0
      t.references :referencable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
