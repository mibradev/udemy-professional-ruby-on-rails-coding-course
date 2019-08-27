# frozen_string_literal: true

class AuditLogPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || (user.employee? && user.id == record.user_id)
  end

  def update?
    user.employee? && user.id == record.user_id && record.pending?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
