# frozen_string_literal: true

class OrderRepository
  def initialize(db = Order)
    @db = db
  end

  def fetch_paginate(per_page: 15, page: 1, sort_field: 'id', sort_direction: 'desc', filter: {})
    offset = (page.to_i - 1) * per_page.to_i
    total_records = filter_query(filter).count.to_i
    total_pages = (total_records / per_page.to_i).ceil

    result = filter_query(filter)
               .order("#{sort_field} #{sort_direction}")
               .limit(per_page).offset(offset)

    [result, total_records, total_pages, per_page.to_i, page.to_i]

  end

  def get_by_uid(uid)
    @db.find_by(uid: uid)
  end

  def get_by_uid_with_association(uid)
    @db.includes(:customer, :order_details => :product).find_by(uid: uid)

  end

  def store(param)
    row = @db.new(param)
    if param[:uid].blank?
      row.uid = SecureRandom.uuid
    else
      row.uid = param[:uid]
    end
    row.save

    row
  end

  private

  def filter_query(filter)
    query = @db.all

    query = query.where(id: filter[:id]) if filter.key?(:id)
    query = query.where(uid: filter[:uid]) if filter.key?(:uid)
    query = query.where(customer_uid: filter[:customer_uid]) if filter.key?(:customer_uid)
    query = query.where(status: filter[:status]) if filter.key?(:status)
    query = query.where(payment_status: filter[:payment_status]) if filter.key?(:payment_status)
    query
  end
end
