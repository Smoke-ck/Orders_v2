require "rails_helper"
require "spec_helper"

RSpec.describe "Home page", chrome: true do
  let(:user) { build(:user, email: "BenJohnson@gmail.com", password:"123456") }

  before { user.save! }

  it "display the the app" do
    visit "/"
    find(:xpath, "//a/img[@alt='en']/..").click
    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"

    click_button "Sign in"
    click_link "Edit Account"
    expect(page).to have_content "EditUser"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    expect(page).to have_content "Password confirmation"
    expect(page).to have_content "Current password"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"
    expect(page).to have_field "Password confirmation"

    click_link "TOTP"
    expect(page).to have_content "Enable Two Factor Authentication"
    expect(page).to have_link "Close"
    expect(page).to have_field "Verify Token"
    expect(page).to have_button "Enable Two Factor"

    user.reload
    fill_in "Verify Token", with: user.otp_code
    click_button "Enable Two Factor"

    expect(page).to have_content "Two Factor Authentication Enabled"
    click_link "Log out"

    find(:xpath, "//a/img[@alt='en']/..").click

    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"
    click_button "Sign in"

    expect(page).to have_content "Two Factor Authentication"
    expect(page).to have_field "Token"
    expect(page).to have_button "Login"

    fill_in "Token", with: "123456"
    click_button "Login"

    expect(page).to have_content "Invalid two-factor code."
    expect(page).to have_content "Two Factor Authentication"
    expect(page).to have_field "Token"
    expect(page).to have_button "Login"

    fill_in "Token", with: user.otp_code
    click_button "Login"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    click_link "Edit Account"
    click_link "TOTP"

    expect(page).to have_content "TOTP"
    click_link "Disable Two Factor"
    expect(page).to have_content "Disable Two Factor Authentication"
    expect(page).to have_content "Two Factor Authentication"
    expect(page).to have_field "Verify Token"
    expect(page).to have_button "Disable Two Factor"

    fill_in "Verify Token", with: user.otp_code
    click_button "Disable Two Factor"

    expect(page).to have_content "EditUser"
    click_link "Log out"

    find(:xpath, "//a/img[@alt='en']/..").click

    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"
    click_button "Sign in"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    click_link "Log out"
  end
end
