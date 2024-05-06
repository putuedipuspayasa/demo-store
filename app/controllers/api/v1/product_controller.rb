class Api::V1::ProductController < ApplicationController
  def initialize(product_repository = ProductRepository.new)
    @product_repo = product_repository
  end

  def fetch_all
    products =  @product_repo.fetch_all
    # render json: products.to_json(include: :category)
    render json: ResponseFormatter.success("success", JSON.parse(products.to_json(include: :category)), 200), status: :ok
  end

  def paginate
    result, total_records, total_pages, per_page, page = @product_repo.fetch_paginate(
      per_page: params[:per_page] || 15,
      page: params[:page] || 1,
      sort_field: params[:sort_field] || 'id',
      sort_direction: params[:sort_direction] || 'DESC',
      filter: params
    )

    meta = { current_page: page, per_page: per_page, total_pages: total_pages, total_records: total_records }

    render json: ResponseFormatter.paginate("success", JSON.parse(result.to_json(include: :category)), meta, 200), status: :ok
  end

  def get_by_uid
    row = @product_repo.get_by_uid(params[:uid])
    if row.present?
      render json: ResponseFormatter.success("success", JSON.parse(row.to_json(include: :category)), 200), status: :ok
    else
      render json: ResponseFormatter.error("record not found", 400), status: :bad_request
    end
  end

  def store
    store_request = ProductStoreRequest.new(product_params)

    if store_request.valid?
      product = @product_repo.store(product_params)
      if product.present?
        render json: ResponseFormatter.success("success", product, 200), status: :ok
      else
        render json: ResponseFormatter.error("internal error", 500, product.errors), status: :internal_server_error
      end
    else
      render json: ResponseFormatter.error("invalid requests", 400, store_request.errors.full_messages), status: :bad_request
    end
  end

  def update
    update_request = ProductUpdateRequest.new(product_params)
    if update_request.valid?
      update_row = @product_repo.update_by_uid(params[:uid], product_params)
      if update_row
        row = @product_repo.get_by_uid(params[:uid])
        render json: ResponseFormatter.success("success", row, 200), status: :ok
      else
        render json: ResponseFormatter.error("internal error", 500, nil), status: :internal_server_error
      end
    else
      render json: ResponseFormatter.error("invalid requests", 400, update_request.errors.full_messages), status: :bad_request
    end

  end

  def delete
    if @product_repo.delete_by_uid(params[:uid])
      render json: ResponseFormatter.success("success", nil, 200), status: :ok

    else
      render json: ResponseFormatter.error("process failed", 400), status: :bad_request
    end
  end

  private

  def product_params
    params.permit(:category_uid, :name, :description, :price, :stock)
  end
end
