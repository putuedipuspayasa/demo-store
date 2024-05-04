# frozen_string_literal: true

class ProductUpdateRequest
  include ActiveModel::Model

  attr_accessor :category_uid, :name, :description, :price, :stock

  validates :category_uid, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :stock, numericality: { only_integer: true }
end
