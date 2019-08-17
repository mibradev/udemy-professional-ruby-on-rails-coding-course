require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
  end

  test "visiting the index by guest" do
    visit root_url
    assert_text I18n.t("devise.failure.unauthenticated")
    assert_selector "h1", text: "Time Tracker"
    assert_no_selector "nav"
  end

  test "visiting the index" do
    sign_in @user
    visit root_url
    assert_selector "h1", text: "Time Tracker"
  end

  test "navigating to home" do
    sign_in @user
    visit root_url
    find("nav").click_link "Home"
    assert_current_path root_path
  end

  test "navigating to posts" do
    sign_in @user
    visit root_url
    find("nav").click_link "Time Entries"
    assert_current_path posts_path
  end

  test "logging out" do
    sign_in @user
    visit root_url
    click_on "Account"
    click_on "Logout"
    assert_text I18n.t("devise.failure.unauthenticated")
  end
end
