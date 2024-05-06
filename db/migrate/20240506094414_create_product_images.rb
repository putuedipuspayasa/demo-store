class CreateProductImages < ActiveRecord::Migration[7.1]
  def change
    create_table :product_images do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :product_uid
      t.string :storage
      t.string :path
      t.string :file_name
    end

    add_index :product_images, :id
    add_index :product_images, :uid, unique: true
    add_index :product_images, :created_at
    add_index :product_images, :updated_at
    add_index :product_images, :product_uid
    add_index :product_images, :storage
    add_index :product_images, :path
    add_index :product_images, :file_name
  end
end
