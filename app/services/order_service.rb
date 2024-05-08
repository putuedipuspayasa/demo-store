# frozen_string_literal: true
class OrderService
  def initialize(
    order_repo = OrderRepository.new,
    order_detail_repo = OrderDetailRepository.new,
    product_repo = ProductRepository.new,
    user_repo = UserRepository.new,
    customer_service = CustomerService.new)
    @order_repo = order_repo
    @order_detail_repo = order_detail_repo
    @product_repo = product_repo
    @user_repo = user_repo
    @customer_service = customer_service
  end

  def create_order(params)
    ActiveRecord::Base.transaction do
      begin
        customer = @customer_service.store(params)
        return :failed if customer.nil?
        order_uid = SecureRandom.uuid
        products = params[:products]
        total_price = 0
        # Loop through products array
        products.each do |product|
          get_product = @product_repo.get_by_uid(product["uid"])
          if get_product.nil?
            return :failed, "invalid product"
          end
          if get_product.stock < product["qty"]
            return :failed, "insufficient stock"
          end
          order_detail = @order_detail_repo.store({
                                                    order_uid: order_uid,
                                                    product_uid: product["uid"],
                                                    price: get_product.price,
                                                    qty: product["qty"],
                                                    notes: nil,
                                                    discount_value: 0
                                                  })

          return :failed if order_detail.nil?
          product_total = product["qty"] * get_product.price
          total_price += product_total
        end
        sub_total = total_price
        discount_total = 0
        tax = 0
        grand_total = (sub_total - discount_total) + tax
        order = @order_repo.store({
                                    uid: order_uid,
                                    customer_uid: customer.uid,
                                    sub_total: total_price,
                                    discount_total: discount_total,
                                    tax: tax,
                                    grand_total: grand_total,
                                    status: ORDER_STATUS[:pending],
                                    payment_status: PAYMENT_STATUS[:pending]
                                  })

        return :success, order
      rescue ActiveRecord::RecordInvalid => e
        raise ActiveRecord::Rollback, e.message
      end
    end
  end
end
