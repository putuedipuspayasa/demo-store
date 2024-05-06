# frozen_string_literal: true

class CustomerRepository
  def initialize(db = Customer)
    @db = db
  end

  def find_by_email_phone(email, phone)
    @db.where("LOWER(email) = :email OR phone = :phone", email: email.downcase, phone: phone).first
  end

  def store(param)
    row = @db.new(param)
    row.uid = SecureRandom.uuid
    row.save

    row
  end
end
