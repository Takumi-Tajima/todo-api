class Todo < ApplicationRecord
  validates :content, presence: true

  scope :default_order, -> { order(:id) }
end
