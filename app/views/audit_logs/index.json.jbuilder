# frozen_string_literal: true

json.array! @audit_logs, partial: "audit_logs/audit_log", as: :audit_log
