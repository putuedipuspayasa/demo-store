# frozen_string_literal: true

class OrderStoreRequest
  include ActiveModel::Model

  attr_accessor :name, :email, :phone, :products

  validates :name, presence: true, length: { minimum: 1 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, numericality: { only_integer: true }
  validates :products, presence: true
  validate :products_must_be_an_array
  validate :products_uid_must_be_present
  validate :products_qty_must_be_integer

  private

  def products_must_be_an_array
    unless products.is_a?(Array)
      errors.add(:products, "must be an array")
    end
  end

  def products_uid_must_be_present
    if products.is_a?(Array)
      products.each do |product|
        unless product["uid"].present?
          errors.add(:products, "uid is required")
          break
        end
      end
    end
  end

  def products_qty_must_be_integer
    if products.is_a?(Array)
      products.each do |product|
        unless product["qty"].is_a?(Integer)
          errors.add(:products, "qty must be an integer")
          break
        end

        unless product["qty"].to_i >= 1
          errors.add(:products, "qty must be at least 1")
          break
        end
      end
    end
  end

  def products_price_must_be_number
    if products.is_a?(Array)
      products.each do |product|
        unless is_numeric?(product["price"])
          errors.add(:products, "price must be a number")
          break
        end
      end
    end
  end

  def is_numeric?(value)
    # Use regex to check if the value can be converted to a number
    value.to_s.match?(/\A-?\d+(\.\d+)?\z/)
  end
end
