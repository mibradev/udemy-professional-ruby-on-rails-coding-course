# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    user.employee? || user.admin?
  end

  def show?
    user.admin? || (user.employee? && user.id == record.user_id)
  end

  def create?
    user.employee?
  end

  def update?
    user.admin? || (user.employee? && user.id == record.user_id && !record.approved?)
  end

  def destroy?
    user.employee? && user.id == record.user_id && !record.approved?
  end

  def change_status?
    user.admin?
  end

  def permitted_attributes
    if user.employee?
      [:overtime_request, :date, :rationale]
    elsif user.admin?
      [:status]
    else
      []
    end
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : user.posts
    end
  end
end
