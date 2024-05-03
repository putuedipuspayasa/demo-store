class CategoryStoreRequest
  include ActiveModel::Model

  attr_accessor :name, :description

  validates :name, presence: true, length: { minimum: 1 }
  # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end