class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :customer_uid
      t.float :sub_total
      t.float :discount_total
      t.float :tax
      t.float :grand_total
      t.text :notes
      t.string :status
    end

    add_index :orders, :id
    add_index :orders, :uid, unique: true
    add_index :orders, :created_at
    add_index :orders, :updated_at
    add_index :orders, :customer_uid
    add_index :orders, :status
  end
end
