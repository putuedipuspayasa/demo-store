# frozen_string_literal: true

class OrderDetailRepository
  def initialize(db = OrderDetail)
    @db = db
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
end
