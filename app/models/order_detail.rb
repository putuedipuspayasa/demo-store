class OrderDetail < ApplicationRecord
  # belongs_to :order, foreign_key: 'order_uid', primary_key: 'uid'
  belongs_to :product, foreign_key: 'product_uid', primary_key: 'uid'
end
