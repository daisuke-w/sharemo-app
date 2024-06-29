class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.references :user,       null: false, foreign_key: true
      t.integer :category_id,   null: false
      t.string :title,          null: false
      t.text :prompt,           null: false
      t.boolean :is_public,     null: false, default: false
      t.timestamps
    end
  end
end
