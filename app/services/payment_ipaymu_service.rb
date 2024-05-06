# frozen_string_literal: true

class PaymentIpaymuService
  require 'net/http'
  def redirect_payment(order, ref_id)
    if Rails.env.production?
      base_url = IPAYMU_CRED_PROD[:base_url]
      va = IPAYMU_CRED_PROD[:va]
      api_key = IPAYMU_CRED_PROD[:api_key]
    else
      base_url = IPAYMU_CRED_DEV[:base_url]
      va = IPAYMU_CRED_DEV[:va]
      api_key = IPAYMU_CRED_DEV[:api_key]
    end
    # Define the URL you want to request
    url = URI.parse("#{base_url}/api/v2/payment")

    products = []
    qty = []
    price = []
    order.order_details.each_with_index do |item, index|
      products[index] = item.product.name.strip
      qty[index] = item.qty
      price[index] = item.price.to_i
    end
    body_params = {
      product: products,
      qty: qty,
      price: price,
      notifyUrl: "https://test.com",
      cancelUrl: "https://test.com",
      referenceId: ref_id.strip,
      buyerName: order.customer.name.strip,
      buyerEmail: order.customer.email.strip,
      buyerPhone: order.customer.phone.strip,
    }
    string_to_sign = generate_string_to_sign("POST", va, body_params.to_json, api_key)
    puts "sts: #{string_to_sign}"
    signature = generate_signature(string_to_sign, api_key)
    puts "sign: #{signature}"
    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json' # Setting the Content-Type header
    request['signature'] = signature
    request['va'] = va

    # Add your request body
    request.body = body_params.to_json

    # Make the request
    response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(request)
    end

    # Check if the response is successful
    if response.is_a?(Net::HTTPSuccess)
      pjson = JSON.parse(response.body)
      rurl = pjson['Data']['Url']
      puts rurl
      return :success, JSON.parse(response.body)
    else
      return :failed, "Request failed with status code #{response.code}: #{response.body}"
    end
  end

  def generate_string_to_sign(http_method, va_number, request_body, api_key)
    # Calculate the SHA-256 hash of the request body and convert it to lowercase
    hashed_body = Digest::SHA256.hexdigest(request_body).downcase

    # Construct the string to sign
    string_to_sign = "#{http_method}:#{va_number}:#{hashed_body}:#{api_key}"
    return string_to_sign
  end

  def generate_signature(string_to_sign, api_key)
    digest = OpenSSL::Digest.new('sha256')
    signature = OpenSSL::HMAC.hexdigest(digest, api_key, string_to_sign)
    return signature
  end
end
