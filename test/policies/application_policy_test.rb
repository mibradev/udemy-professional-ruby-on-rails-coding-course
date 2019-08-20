require 'test_helper'

class ApplicationPolicyTest < ActiveSupport::TestCase
  test "scope" do
    assert_equal User.all, ApplicationPolicy::Scope.new(nil, User).resolve
  end

  test "index" do
    assert_not ApplicationPolicy.new(nil, nil).index?
  end

  test "show" do
    assert_not ApplicationPolicy.new(nil, nil).show?
  end

  test "create" do
    assert_not ApplicationPolicy.new(nil, nil).create?
  end

  test "update" do
    assert_not ApplicationPolicy.new(nil, nil).update?
  end

  test "destroy" do
    assert_not ApplicationPolicy.new(nil, nil).destroy?
  end
end
