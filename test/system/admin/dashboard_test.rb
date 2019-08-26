# frozen_string_literal: true

require "application_system_test_case"

module Admin
  class DashboardTest < ApplicationSystemTestCase
    test "employee visiting admin dashboard" do
      sign_in employee_users(:ahmad)
      visit root_url
      click_on "Options"
      assert_no_selector "a", text: "Admin Dashboard"
      visit admin_root_path
      assert_text "You don't have authorization to view that page."
    end

    test "admin visiting admin dashboard" do
      sign_in admin_users(:admin)
      visit root_url
      click_on "Options"
      click_on "Admin Dashboard"
      assert_current_path admin_root_path
    end
  end
end
