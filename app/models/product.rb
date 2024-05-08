class Product < ApplicationRecord
  belongs_to :category, foreign_key: 'category_uid', primary_key: 'uid'
end
