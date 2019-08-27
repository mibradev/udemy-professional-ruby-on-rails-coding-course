# frozen_string_literal: true

class Post < ApplicationRecord
  validates :overtime_request, numericality: { greater_than: 0.0, less_than_or_equal_to: 20.0 }
  validates :date, presence: true
  validates :rationale, presence: true

  after_save :confirm_audit_log, if: :submitted?
  after_save :unconfirm_audit_log, if: :rejected?

  belongs_to :user
  has_many :audit_logs, through: :user

  enum status: { submitted: 0, approved: 1, rejected: 2 }

  private
    def confirm_audit_log
      audit_logs.pending.started_before(self).last&.confirmed!
    end

    def unconfirm_audit_log
      audit_logs.confirmed.started_before(self).last&.pending!
    end
end
