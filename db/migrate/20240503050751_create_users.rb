class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :name
      t.string :email
      t.string :phone
      t.string :user_type
      t.string :status
      t.string :password_digest
    end

    add_index :users, :id
    add_index :users, :uid, unique: true
    add_index :users, :created_at
    add_index :users, :updated_at
    add_index :users, :name
    add_index :users, :email
    add_index :users, :phone
    add_index :users, :user_type
    add_index :users, :status
  end

  def down
    drop_table :users
  end
end
