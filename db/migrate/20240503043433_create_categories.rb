class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :name
      t.text :description
    end

    add_index :categories, :id
    add_index :categories, :uid, unique: true
    add_index :categories, :created_at
    add_index :categories, :updated_at
    add_index :categories, :name
  end
end
