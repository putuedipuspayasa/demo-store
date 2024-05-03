class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :uid
      t.timestamps
      t.string :category_uid
      t.string :name
      t.text :description
      t.float :price
      t.integer :stock
    end
  end
end
