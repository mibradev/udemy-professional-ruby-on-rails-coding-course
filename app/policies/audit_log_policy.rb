# frozen_string_literal: true

class AuditLogPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || record.user_id == user.id
  end

  def update?
    record.pending? && record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
