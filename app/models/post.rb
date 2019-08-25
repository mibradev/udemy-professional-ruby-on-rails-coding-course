# frozen_string_literal: true

class Post < ApplicationRecord
  validates :overtime_request, numericality: { greater_than: 0.0, less_than_or_equal_to: 20.0 }
  validates :date, presence: true
  validates :rationale, presence: true

  after_save :update_audit_log

  belongs_to :user
  has_many :audit_logs, through: :user

  enum status: { submitted: 0, approved: 1, rejected: 2 }

  private
    def update_audit_log
      audit_logs.pending.where(start_date: (date - 7.days)..date).last&.confirmed!
    end
end
