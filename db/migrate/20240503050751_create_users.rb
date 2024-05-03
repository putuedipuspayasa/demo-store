class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.timestamps
      t.string :name
      t.string :email
      t.string :phone
      t.string :type
      t.string :status
    end
  end
end
