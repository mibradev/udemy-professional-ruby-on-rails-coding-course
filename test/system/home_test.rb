# frozen_string_literal: true

require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "guest visiting the index" do
    visit root_url
    assert_text I18n.t("devise.failure.unauthenticated")
    assert_selector "h1", text: "Time Tracker"
    assert_no_selector "nav"
  end

  test "employee visiting the index" do
    sign_in employee_users(:ahmad)
    visit root_url
    find("nav").click_link "Home"
    assert_selector "h1", text: "Time Tracker"
    assert_no_selector "h2", text: "Items Pending Your Approval"
    assert_no_selector "h2", text: "Confirmation Log"
  end

  test "employee confirming an audit log" do
    sign_in employee_users(:ahmad)
    visit root_url
    page.accept_confirm { click_on "Confirm" }
    assert_text "Audit log was successfully updated"
  end

  test "employee requesting overtime" do
    sign_in employee_users(:ahmad)
    visit root_url
    click_on "Request Overtime"
    assert_current_path new_post_path
  end

  test "admin visiting the index" do
    sign_in admin_users(:admin)
    visit root_url
    assert_selector "h2", text: "Items Pending Your Approval"
    assert_selector "h2", text: "Confirmation Log"
  end

  test "admin approving a post" do
    sign_in admin_users(:admin)
    visit root_url
    click_on "Approve", match: :first
    assert_text "Post was successfully updated"
  end

  test "admin reviewing a post" do
    sign_in admin_users(:admin)
    visit root_url
    click_on "Review", match: :first
    assert_text "Editing Post"
  end

  test "logging out" do
    sign_in employee_users(:ahmad)
    visit root_url
    click_on "Options"
    click_on "Logout"
    assert_text I18n.t("devise.failure.unauthenticated")
  end
end
