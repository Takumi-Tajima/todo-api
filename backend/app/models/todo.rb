class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :due_date, presence: true

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :overdue, -> { where(due_date: ...Date.current).incomplete }
  scope :ordered_by_priority, -> { order(priority: :desc) }
end
