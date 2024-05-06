class Api::V1::CategoryController < ApplicationController
    def initialize(category_repository = CategoryRepository.new)
        @category_repo = category_repository
    end

    def fetch_all
        categories = @category_repo.fetch_all
        render json: ResponseFormatter.success("success", categories, 200), status: :ok
    end

    def paginate
        result, total_records, total_pages, per_page, page = @category_repo.fetch_paginate(
            per_page: params[:per_page] || 15,
            page: params[:page] || 1,
            sort_field: params[:sort_field] || 'id',
            sort_direction: params[:sort_direction] || 'DESC',
            filter: params
        )

        meta = { current_page: page, per_page: per_page, total_pages: total_pages, total_records: total_records }

        render json: ResponseFormatter.paginate("success", result, meta, 200), status: :ok
    end

    def get_by_uid
        category = @category_repo.get_by_uid(params[:uid])
        if category.present?
            render json: ResponseFormatter.success("success", category, 200), status: :ok
        else
            render json: ResponseFormatter.error("record not found", 400), status: :bad_request
        end

        # rescue ActiveRecord::RecordNotFound
        #     render json: ResponseFormatter.error("record not found", 400), status: :bad_request

    end

    def store
        store_request = CategoryStoreRequest.new(category_params)

        if store_request.valid?
            category = @category_repo.store(category_params)
            if category.present?
                render json: ResponseFormatter.success("success", category, 200), status: :ok
            else
                render json: ResponseFormatter.error("internal error", 500, category.errors), status: :internal_server_error
            end
        else
            render json: ResponseFormatter.error("invalid requests", 400, store_request.errors.full_messages), status: :bad_request
        end
    end

    def update
        update_request = CategoryUpdateRequest.new(category_params)
        if update_request.valid?
            update_category = @category_repo.update_by_uid(params[:uid], category_params)
            if update_category
                category = @category_repo.get_by_uid(params[:uid])
                render json: ResponseFormatter.success("success", category, 200), status: :ok
            else
                render json: ResponseFormatter.error("internal error", 400, nil), status: :internal_server_error
            end
        else
            render json: ResponseFormatter.error("invalid requests", 400, update_request.errors.full_messages), status: :bad_request
        end

    end

    def delete
        if @category_repo.delete_by_uid(params[:uid])
            render json: ResponseFormatter.success("success", nil, 200), status: :ok
        else
            render json: ResponseFormatter.error("process failed", 400), status: :bad_request
        end
    end


    private

    def category_params
        params.permit(:name, :description)
    end

end
