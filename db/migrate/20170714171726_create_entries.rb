class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :team, foreign_key: true
      t.references :user, index: true
      t.text :encrypted_data

      t.timestamps
    end
  end
end
