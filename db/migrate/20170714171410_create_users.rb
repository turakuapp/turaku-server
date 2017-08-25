class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :authentication_salt

      t.timestamps
    end
  end
end
