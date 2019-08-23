# frozen_string_literal: true

class AuditLog < ApplicationRecord
  validates :status, presence: true
  validates :start_date, presence: true

  after_initialize :set_defaults

  belongs_to :user

  enum status: [:pending, :confirmed]

  private
    def set_defaults
      self.start_date ||= 6.days.ago.to_date
    end
end
