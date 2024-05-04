class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :name
      t.string :email
      t.string :phone
      t.string :type
      t.string :status
    end

    add_index :users, :id
    add_index :users, :uid, unique: true
    add_index :users, :created_at
    add_index :users, :updated_at
    add_index :users, :name
    add_index :users, :email
    add_index :users, :phone
    add_index :users, :type
    add_index :users, :status
  end
end
