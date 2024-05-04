# frozen_string_literal: true

class OrderRepository
  def initialize(db = Order)
    @db = db
  end

  def store(param)
    row = @db.new(param)
    row.uid = SecureRandom.uuid
    row.save

    row
  end
end
