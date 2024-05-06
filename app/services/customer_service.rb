# frozen_string_literal: true

class CustomerService
  def initialize(customer_repo = CustomerRepository.new, user_repo = UserRepository.new)
    @customer_repo = customer_repo
    @user_repo = user_repo
  end

  def store(params)
    customer = @customer_repo.find_by_email_phone(params[:email], params[:phone])
    if customer.nil?
      user_params = {
        email: params[:email].downcase,
        phone: params[:phone],
        name: params[:name],
        user_type: USER_TYPE[:customer],
      }
      if params[:password].nil?
        # user_params[:password] = BCrypt::Password.create(Helpers.generate_random_password(8))
        user_params[:password] = Helpers.generate_random_password(8)
      else
        user_params[:password] =  params[:password]
      end

      user = @user_repo.store(user_params)
      return error if user.nil?

      customer = @customer_repo.store({
                                        user_uid: user.uid,
                                        email: params[:email].downcase,
                                        phone: params[:phone],
                                        name: params[:name],
                                      })
      return error if customer.nil?
      customer

    else
    customer
    end
  end
end
