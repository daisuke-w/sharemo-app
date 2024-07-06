class CreatePromptTags < ActiveRecord::Migration[7.0]
  def change
    create_table :prompt_tags do |t|
      t.references :prompt, null: false, foreign_key: true
      t.references :tag,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
