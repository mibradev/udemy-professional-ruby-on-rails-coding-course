require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should have date" do
    @post.date = nil
    assert_not @post.valid?
  end

  test "should have rationale" do
    @post.rationale = nil
    assert_not @post.valid?
  end
end
