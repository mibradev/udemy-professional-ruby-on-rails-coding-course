class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || record.user_id == user.id
  end

  def create?
    true
  end

  def update?
    user.admin? || (record.user_id == user.id && !record.approved?)
  end

  def destroy?
    update?
  end

  def change_status?
    user.admin?
  end

  def permitted_attributes
    params = [:date, :rationale]
    user.admin? ? params.push(:status) : params
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : user.posts
    end
  end
end
