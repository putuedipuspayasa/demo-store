# frozen_string_literal: true

class PaymentService
  def initialize(order_repo = OrderRepository.new, payment_repo = PaymentRepository.new, payment_ipaymu = PaymentIpaymuService.new)
    @order_repo = order_repo
    @payment_repo = payment_repo
    @payment_ipaymu = payment_ipaymu
  end

  def payment_by_order_uid(order_uid)
    order = @order_repo.get_by_uid_with_association(order_uid)
    return :failed if order.nil?

    if order.status != ORDER_STATUS[:pending]
      return :failed, "invalid order status"
    end

    if order.payment_status != PAYMENT_STATUS[:pending]
      return :failed, "invalid payment status"
    end

    internal_ref_id = DateTime.now.strftime("%Y%m%d%H%M%S%L").to_s

    status, payment_vendor = @payment_ipaymu.redirect_payment(order, internal_ref_id)
    if status != :success
      return :failed, payment_vendor
    end

    #   store payment
    payment = @payment_repo.store({
                                    order_uid: order.uid,
                                    amount: order.grand_total,
                                    status: PAYMENT_STATUS[:pending],
                                    ref_id: internal_ref_id,
                                    payment_code: payment_vendor['Data']['Url']
                                  })
    if payment.nil?
      return :failed, "payment failed"
    end

    return :success, payment
  end
end
