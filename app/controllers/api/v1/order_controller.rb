class Api::V1::OrderController < ApplicationController
  def initialize(category_repository = CategoryRepository.new)
    @category_repo = category_repository
  end

  def store
    store_request = OrderStoreRequest.new(order_params)

    if store_request.valid?
      render json: ResponseFormatter.success("yes", 200, nil), status: :ok
    else
      render json: ResponseFormatter.error("invalid requests", 400, store_request.errors.full_messages), status: :bad_request
    end
  end



  private

  def order_params
    params.permit(:name, :email, :phone, products: [:uid, :qty, :price])
  end
end
