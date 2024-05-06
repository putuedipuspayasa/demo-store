class Order < ApplicationRecord
  has_many :order_details, foreign_key: 'order_uid', primary_key: 'uid'
  belongs_to :customer, foreign_key: 'customer_uid', primary_key: 'uid'
end
