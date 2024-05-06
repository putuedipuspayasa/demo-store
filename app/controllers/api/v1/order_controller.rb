class Api::V1::OrderController < ApplicationController
  def initialize(order_service = OrderService.new, order_repo = OrderRepository.new)
    @order_service = order_service
    @order_repo  = order_repo
  end
  def paginate
    result, total_records, total_pages, per_page, page = @order_repo.fetch_paginate(
      per_page: params[:per_page] || 15,
      page: params[:page] || 1,
      sort_field: params[:sort_field] || 'id',
      sort_direction: params[:sort_direction] || 'DESC',
      filter: params
    )
    meta = { current_page: page, per_page: per_page, total_pages: total_pages, total_records: total_records }

    render json: ResponseFormatter.paginate("success", JSON.parse(result.to_json(include: [:customer])), meta, 200), status: :ok
  end

  def get_by_uid
    row = @order_repo.get_by_uid(params[:uid])
    if row.present?
      render json: ResponseFormatter.success("success", JSON.parse(row.to_json(include: [:customer, { order_details: { include: {product: {include: :category}} }}])), 200), status: :ok
    else
      render json: ResponseFormatter.error("record not found", 400), status: :bad_request
    end
  end
  def store
    store_request = OrderStoreRequest.new(order_params)
    if store_request.valid?

      result, order = @order_service.create_order(order_params)
      case result
      when :success
        render json: ResponseFormatter.success("success", JSON.parse(order.to_json(include: [:customer, :order_details])), 200), status: :ok
      when :failed
        render json: ResponseFormatter.error(order, 400, nil), status: :unprocessable_entity
      else
        render json: ResponseFormatter.error("internal error", 500, nil), status: :internal_server_error
      end

    else
      render json: ResponseFormatter.error("invalid requests", 400, store_request.errors.full_messages), status: :bad_request
    end
  end

  private
  def order_params
    params.permit(:name, :email, :phone, products: [:uid, :qty])
  end
end
