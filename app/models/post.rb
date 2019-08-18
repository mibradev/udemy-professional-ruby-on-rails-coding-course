class Post < ApplicationRecord
  validates :overtime_request, numericality: { greater_than: 0.0, less_than_or_equal_to: 20.0 }
  validates :date, presence: true
  validates :rationale, presence: true

  belongs_to :user

  enum status: { submitted: 0, approved: 1, rejected: 2 }
end
