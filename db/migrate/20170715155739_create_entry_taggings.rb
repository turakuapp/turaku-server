class CreateEntryTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_taggings do |t|
      t.references :entry, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
