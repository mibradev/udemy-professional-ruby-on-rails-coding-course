# frozen_string_literal: true

class AuditLog < ApplicationRecord
  validates :status, presence: true
  validates :start_date, presence: true

  after_initialize :set_defaults
  before_update :set_end_date, if: :confirmed?

  belongs_to :user

  scope :started_before, ->(post) { where(start_date: post.date.ago(7.days)..post.date) }
  enum status: [:pending, :confirmed]

  private
    def set_defaults
      self.start_date ||= 6.days.ago.to_date
    end

    def set_end_date
      self.end_date = Date.current
    end
end
