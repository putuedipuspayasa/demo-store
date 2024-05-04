class Category < ApplicationRecord
  # has_many :products, foreign_key: 'category_uid', primary_key: 'uid'
  has_many :products, foreign_key: 'category_uid', primary_key: 'uid'
end
