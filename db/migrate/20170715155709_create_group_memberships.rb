class CreateGroupMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :group_memberships do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
