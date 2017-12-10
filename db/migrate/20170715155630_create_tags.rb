class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.text :encrypted_name
      t.string :name_hash, index: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
