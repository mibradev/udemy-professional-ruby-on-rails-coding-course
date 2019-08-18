require 'test_helper'

class PostsHelperTest < ActionView::TestCase
  test "should return status badge" do
    assert_dom_equal %{<span class="badge badge-primary">Submitted</span>}, status_badge(posts(:submitted))
    assert_dom_equal %{<span class="badge badge-success">Approved</span>}, status_badge(posts(:approved))
    assert_dom_equal %{<span class="badge badge-danger">Rejected</span>}, status_badge(posts(:rejected))
  end
end
