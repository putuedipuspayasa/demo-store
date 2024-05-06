module Helpers
  def self.generate_random_password(length = 8)
    SecureRandom.hex(length)
  end
end