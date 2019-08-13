require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    sign_in users(:user)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit new_post_url
    fill_in "Date", with: @post.date
    fill_in "Rationale", with: @post.rationale
    click_on "Create Post"
    assert_text "Post was successfully created"
  end
end
