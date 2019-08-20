# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  attr_reader :request

  setup do
    request.path = root_path
  end

  test "should return active link class" do
    assert_equal "active", active_link_class(root_path)
  end

  test "should return active link" do
    assert_dom_equal %{<a class="active" href="/">Home</a>}, active_link_to("Home", root_path)
    assert_dom_equal %{<a class="nav-link custom active" href="/">Home</a>}, active_link_to("Home", root_path, class: "nav-link custom")
    assert_dom_equal %{<a class="nav-link active" href="/">Home</a>}, active_link_to("Home", root_path, class: ["nav-link"])
  end
end
