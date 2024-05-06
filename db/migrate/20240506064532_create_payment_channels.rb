class CreatePaymentChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_channels do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :name
      t.text :description
      t.text :notes
      t.string :payment_flow
      t.string :media_uid
      t.string :status
      t.string :vendor
    end

    add_index :payment_channels, :id
    add_index :payment_channels, :uid, unique: true
    add_index :payment_channels, :created_at
    add_index :payment_channels, :updated_at
    add_index :payment_channels, :name
    add_index :payment_channels, :status
    add_index :payment_channels, :vendor
  end
end
