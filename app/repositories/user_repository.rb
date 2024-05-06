# frozen_string_literal: true

class UserRepository
  def initialize(db = User)
    @db = db
  end

  def store(param)
    row = @db.new(param)
    row.uid = SecureRandom.uuid
    row.save

    row
  end
end
