class Api::V1::PaymentController < ApplicationController
  def initialize(payment_service = PaymentService.new)
    @payment_service = payment_service
  end
  def payment_by_order
    payment_request = PaymentByOrderRequest.new(payment_params)

    if payment_request.valid?
      status, payment = @payment_service.payment_by_order_uid(payment_params[:order_uid])
      case status
      when :success
        render json: ResponseFormatter.success("success", payment, 200), status: :ok
      when :failed
        render json: ResponseFormatter.error(payment, 400, nil), status: :unprocessable_entity
      else
        render json: ResponseFormatter.error("internal error", 500, nil), status: :internal_server_error
      end
    else
      render json: ResponseFormatter.error("invalid requests", 400, payment_request.errors.full_messages), status: :bad_request
    end
  end

  private
  def payment_params
    params.permit(:order_uid)
  end
end
