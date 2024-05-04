# frozen_string_literal: true

class OrderDetailRepository
  def initialize(db = OrderDetail)
    @db = db
  end

  def store(param)
    row = @db.new(param)
    row.uid = SecureRandom.uuid
    row.save

    row
  end
end
