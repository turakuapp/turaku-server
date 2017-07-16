class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
      t.references :team, foreign_key: true
      t.references :user, index: true
      t.references :entry, index: true
      t.text :activity

      t.timestamps
    end
  end
end
