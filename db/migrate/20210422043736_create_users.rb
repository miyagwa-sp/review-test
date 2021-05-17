class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :name
      t.string :role
      t.integer :failed_login_count
      t.datetime :last_login_at
      t.timestamps
    end
  end
end
