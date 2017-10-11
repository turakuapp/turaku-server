class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.datetime :sent_at
      t.datetime :accepted_at
      t.references :invited_user, references: :users, null: false
      t.references :inviting_user, references: :users, null: false
      t.references :team, foreign_key: true, null: false

      t.timestamps
    end

    add_foreign_key :invitations, :users, column: :inviting_user_id
  end
end
