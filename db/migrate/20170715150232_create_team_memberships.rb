class CreateTeamMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :team_memberships do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.string :default_permission_level

      t.timestamps
    end
  end
end
