class Callback::Payment::IpaymuController < ApplicationController
  def initialize(payment_repo = PaymentRepository.new, payment_service = PaymentService.new)
    @payment_repo = payment_repo
    @payment_service = payment_service
  end

  def callback

  end
end
