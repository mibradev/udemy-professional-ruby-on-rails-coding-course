require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  def setup
    @user = users(:user)
    sign_in @user
  end

  test "visiting the index by guest user" do
    sign_out @user
    visit root_url
    assert_text I18n.t("devise.failure.unauthenticated")
    assert_selector "h1", text: "Time Tracker"
    assert_no_selector "nav a", text: "Home"
  end

  test "visiting the index by logged in user" do
    visit root_url
    assert_selector "h1", text: "Time Tracker"
    assert_selector "nav a", text: "Home"
    assert_selector "nav a", text: "Time Entries"
    assert_selector "nav a", text: "Account"

    click_on "Account"
    assert_selector "nav a", text: "Edit Details"
    assert_selector "nav a", text: "Logout"
  end
end
