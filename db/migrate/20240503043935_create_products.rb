class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :category_uid
      t.string :name
      t.text :description
      t.float :price, default: 0
      t.integer :stock, default: 0
    end

    add_index :products, :id
    add_index :products, :uid, unique: true
    add_index :products, :created_at
    add_index :products, :updated_at
    add_index :products, :category_uid
    add_index :products, :name
  end

  def down
    drop_table :products
  end
end
