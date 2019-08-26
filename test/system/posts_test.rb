# frozen_string_literal: true

require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:submitted)
  end

  test "visiting the index" do
    sign_in employee_users(:ahmad)
    visit root_url
    find("nav").click_link "Time Entries"
    assert_selector "h2", text: "Posts"
    assert_selector "table th", text: "#"
    assert_selector "table th", text: "Overtime Request"
    assert_selector "table th", text: "Date"
    assert_selector "table th", text: "Status"
    assert_selector "table th", text: "User"
    assert_selector "table th", text: "Rationale"
    assert_selector "table th", text: @post.id
    assert_selector "table td", text: @post.overtime_request
    assert_selector "table td", text: @post.date
    assert_selector "table td", text: @post.status.titleize
    assert_selector "table td", text: @post.user.full_name
    assert_selector "table td", text: @post.rationale
  end

  test "visiting the index with no posts found" do
    sign_in employee_users(:ahmad)
    Post.delete_all
    visit posts_url
    assert_selector "h2", text: "Posts"
    assert_selector "p", text: "No posts found."
    assert_no_selector "table"
  end

  test "showing the post" do
    sign_in employee_users(:ahmad)
    visit posts_url
    click_on "Show", match: :first
    assert_selector "h2", text: "Post ##{@post.id}"
    assert_selector "dt", text: "Overtime request"
    assert_selector "dd", text: @post.overtime_request
    assert_selector "dt", text: "Date"
    assert_selector "dd", text: @post.date
    assert_selector "dt", text: "Rationale"
    assert_selector "dd", text: @post.rationale
    assert_selector "dt", text: "Status"
    assert_selector "dd", text: @post.status.titleize
  end

  test "creating a post" do
    sign_in employee_users(:ahmad)
    visit posts_url
    click_on "New Post"

    click_on "Create Post"
    assert_text "3 errors prohibited this record from being saved:"
    assert_text "Overtime request #{I18n.t('errors.messages.greater_than', count: 0.0)}"
    assert_text "Date #{I18n.t('errors.messages.blank')}"
    assert_text "Rationale #{I18n.t('errors.messages.blank')}"

    fill_in "Overtime request", with: 20.1
    click_on "Create Post"
    assert_text "Overtime request #{I18n.t('errors.messages.less_than_or_equal_to', count: 20.0)}"

    assert_selector "h2", text: "New Post"
    assert_no_selector "input[name='post[status]']"
    fill_in "Overtime request", with: @post.overtime_request
    fill_in "Date", with: @post.date
    fill_in "Rationale", with: @post.rationale
    click_on "Create Post"
    assert_text "Post was successfully created"
  end

  test "updating a post" do
    sign_in employee_users(:ahmad)
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Overtime request", with: nil
    fill_in "Date", with: nil
    fill_in "Rationale", with: nil
    click_on "Update Post"
    assert_text "3 errors prohibited this record from being saved:"
    assert_text "Overtime request #{I18n.t('errors.messages.not_a_number')}"
    assert_text "Date #{I18n.t('errors.messages.blank')}"
    assert_text "Rationale #{I18n.t('errors.messages.blank')}"

    fill_in "Overtime request", with: 0.0
    click_on "Update Post"
    assert_text "Overtime request #{I18n.t('errors.messages.greater_than', count: 0.0)}"

    fill_in "Overtime request", with: 20.1
    click_on "Update Post"
    assert_text "Overtime request #{I18n.t('errors.messages.less_than_or_equal_to', count: 20.0)}"

    assert_selector "h2", text: "Editing Post ##{@post.id}"
    assert_no_selector "input[name='post[status]']"
    fill_in "Overtime request", with: @post.overtime_request
    fill_in "Date", with: @post.date
    fill_in "Rationale", with: @post.rationale
    click_on "Update Post"
    assert_text "Post was successfully updated"
  end

  test "unable to update an approved post" do
    sign_in employee_users(:ahmad)
    Post.where.not(status: "approved").delete_all

    visit posts_url
    assert_selector "a.disabled", text: "Edit"

    visit post_url(posts(:approved))
    assert_selector "a.disabled", text: "Edit"
  end

  test "destroying a post" do
    sign_in employee_users(:ahmad)
    visit posts_url
    page.accept_confirm { click_on "Delete", match: :first }
    assert_text "Post was successfully destroyed"
  end

  test "destroying a post from show" do
    sign_in employee_users(:ahmad)
    visit post_url(@post)
    page.accept_confirm { click_on "Delete" }
    assert_text "Post was successfully destroyed"
  end

  test "unable to destroy an approved post" do
    sign_in employee_users(:ahmad)
    Post.where.not(status: "approved").delete_all

    visit posts_url
    assert_selector "a.disabled", text: "Delete"

    visit post_url(posts(:approved))
    assert_selector "a.disabled", text: "Delete"
  end

  test "navigating between show and edit" do
    sign_in employee_users(:ahmad)
    visit post_url(@post)
    assert_current_path post_path(@post)
    click_on "Edit"
    assert_current_path edit_post_path(@post)
    click_on "Show"
    assert_current_path post_path(@post)
  end

  test "approving a post" do
    sign_in admin_users(:admin)
    visit edit_post_url(@post)
    choose "Approved"
    click_on "Update Post"
    assert @post.reload.approved?
  end

  test "rejecting a post" do
    sign_in admin_users(:admin)
    visit edit_post_url(@post)
    choose "Rejected"
    click_on "Update Post"
    assert @post.reload.rejected?
  end
end
