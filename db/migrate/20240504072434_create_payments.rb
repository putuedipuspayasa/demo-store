class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :uid, null: false
      t.timestamps
      t.string :order_uid
      t.float :amount
      t.timestamp :paid_at
      t.string :status
      t.string :type
      t.string :payment_channel_uid
      t.string :payment_code
      t.string :payment_url
      t.string :payment_name
      t.text :notes
    end

    add_index :payments, :id
    add_index :payments, :uid, unique: true
    add_index :payments, :created_at
    add_index :payments, :updated_at
    add_index :payments, :order_uid
    add_index :payments, :paid_at
    add_index :payments, :status
    add_index :payments, :type
    add_index :payments, :payment_channel_uid
    add_index :payments, :payment_code
    add_index :payments, :payment_url
  end
end
