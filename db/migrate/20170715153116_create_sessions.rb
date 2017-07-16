class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :name
      t.references :user, index: true
      t.string :token_hash
      t.datetime :last_used_at

      t.timestamps
    end

    add_index :sessions, :token_hash
  end
end
