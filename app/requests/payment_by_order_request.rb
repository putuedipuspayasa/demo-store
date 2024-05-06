# frozen_string_literal: true

class PaymentByOrderRequest
  include ActiveModel::Model

  attr_accessor :order_uid

  validates :order_uid, presence: true
end
