class Post < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :rationale, presence: true
end
