class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :team, foreign_key: true
      t.references :user, index: true
      t.references :group, index: true
      t.references :entry, index: true
      t.references :tag, index: true
      t.string :level

      t.timestamps
    end
  end
end
