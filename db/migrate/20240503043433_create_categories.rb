class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :uid
      t.timestamps
      t.string :name
      t.text :description
    end
  end
end
