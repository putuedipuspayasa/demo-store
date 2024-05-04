class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :user_uid
      t.string :name
      t.string :email
      t.string :phone
    end
    add_index :customers, :id
    add_index :customers, :uid, unique: true
    add_index :customers, :created_at
    add_index :customers, :updated_at
    add_index :customers, :name
    add_index :customers, :email
    add_index :customers, :phone
  end
end
