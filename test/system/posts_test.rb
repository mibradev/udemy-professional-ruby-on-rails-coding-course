require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:submitted)
    sign_in admin_users(:admin)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h2", text: "Posts"
    assert_selector "table th", text: "#"
    assert_selector "table th", text: "Date"
    assert_selector "table th", text: "Status"
    assert_selector "table th", text: "User"
    assert_selector "table th", text: "Rationale"
    assert_selector "table th", text: @post.id
    assert_selector "table td", text: @post.date
    assert_selector "table td", text: @post.status.titleize
    assert_selector "table td", text: @post.user.full_name
    assert_selector "table td", text: @post.rationale
  end

  test "visiting the index with no posts found" do
    Post.delete_all
    visit posts_url
    assert_selector "h2", text: "Posts"
    assert_selector "p", text: "No posts found."
    assert_no_selector "table"
  end

  test "showing the post" do
    visit posts_url
    click_on "Show", match: :first
    assert_selector "h2", text: "Post ##{@post.id}"
    assert_selector "dt", text: "Date"
    assert_selector "dd", text: @post.date
    assert_selector "dt", text: "Rationale"
    assert_selector "dd", text: @post.rationale
    assert_selector "dt", text: "Status"
    assert_selector "dd", text: @post.status.titleize
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    click_on "Create Post"
    assert_text "2 errors prohibited this record from being saved:"
    assert_text "Date #{I18n.t('errors.messages.blank')}"
    assert_text "Rationale #{I18n.t('errors.messages.blank')}"

    assert_selector "h2", text: "New Post"
    fill_in "Date", with: @post.date
    fill_in "Rationale", with: @post.rationale
    click_on "Create Post"
    assert_text "Post was successfully created"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Date", with: nil
    fill_in "Rationale", with: nil
    click_on "Update Post"
    assert_text "2 errors prohibited this record from being saved:"
    assert_text "Date #{I18n.t('errors.messages.blank')}"
    assert_text "Rationale #{I18n.t('errors.messages.blank')}"

    assert_selector "h2", text: "Editing Post ##{@post.id}"
    fill_in "Date", with: @post.date
    fill_in "Rationale", with: @post.rationale
    click_on "Update Post"
    assert_text "Post was successfully updated"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm { click_on "Delete", match: :first }
    assert_text "Post was successfully destroyed"
  end

  test "navigating between show and edit" do
    visit post_url(@post)
    assert_current_path post_path(@post)
    click_on "Edit"
    assert_current_path edit_post_path(@post)
    click_on "Show"
    assert_current_path post_path(@post)
  end

  test "approving a Post" do
    visit edit_post_url(@post)
    choose "Approved"
    click_on "Update Post"
    assert @post.reload.approved?
  end

  test "rejecting a Post" do
    visit edit_post_url(@post)
    choose "Rejected"
    click_on "Update Post"
    assert @post.reload.rejected?
  end
end
