class CategoryUpdateRequest
  include ActiveModel::Model

  attr_accessor :name, :description

  validates :name, presence: true, length: { minimum: 1 }
end