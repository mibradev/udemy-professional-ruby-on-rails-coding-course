# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record.user_id == user.id
  end

  def create?
    user.employee?
  end

  def update?
    user.admin? || (record.user_id == user.id && !record.approved?)
  end

  def destroy?
    record.user_id == user.id && !record.approved?
  end

  def change_status?
    user.admin?
  end

  def permitted_attributes
    user.admin? ? [:status] : [:overtime_request, :date, :rationale]
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : user.posts
    end
  end
end
