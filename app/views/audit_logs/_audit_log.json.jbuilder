# frozen_string_literal: true

json.extract! audit_log, :id, :status, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url audit_log_url(audit_log, format: :json)
