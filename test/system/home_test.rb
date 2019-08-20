# frozen_string_literal: true

require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "visiting the index by guest" do
    visit root_url
    assert_text I18n.t("devise.failure.unauthenticated")
    assert_selector "h1", text: "Time Tracker"
    assert_no_selector "nav"
  end

  test "visiting the index" do
    sign_in users(:user)
    visit root_url
    assert_selector "h1", text: "Time Tracker"
  end

  test "navigating to home" do
    sign_in users(:user)
    visit root_url
    find("nav").click_link "Home"
    assert_current_path root_path
  end

  test "navigating to posts" do
    sign_in users(:user)
    visit root_url
    find("nav").click_link "Time Entries"
    assert_current_path posts_path
  end

  test "visiting admin by user" do
    sign_in users(:user)
    visit root_url
    click_on "Options"
    assert_no_selector "a", text: "Admin Dashboard"
    visit admin_root_path
    assert_text "You don't have authorization to view that page."
  end

  test "navigating to admin" do
    sign_in admin_users(:admin)
    visit root_url
    click_on "Options"
    click_on "Admin Dashboard"
    assert_current_path admin_root_path
  end

  test "logging out" do
    sign_in users(:user)
    visit root_url
    click_on "Options"
    click_on "Logout"
    assert_text I18n.t("devise.failure.unauthenticated")
  end
end
