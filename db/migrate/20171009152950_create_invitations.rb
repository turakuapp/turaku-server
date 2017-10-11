class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.references :invited_user, references: :users
      t.references :inviting_user, references: :users

      t.timestamps
    end

    add_foreign_key :invitations, :users, column: :inviting_user_id
  end
end
