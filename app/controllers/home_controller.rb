# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user.admin?
      @submitted_posts = Post.submitted.includes(:user)
      @recent_audit_logs = AuditLog.last(10)
    end
  end
end
