# frozen_string_literal: true

class PaymentRepository
  def initialize(db = Payment)
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
