class CreateOrderDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :order_details do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :order_uid
      t.string :product_uid
      t.float :price
      t.integer :qty
      t.float :discount_value
      t.text :notes
    end

    add_index :order_details, :id
    add_index :order_details, :uid, unique: true
    add_index :order_details, :created_at
    add_index :order_details, :updated_at
    add_index :order_details, :order_uid
    add_index :order_details, :product_uid
  end
end
