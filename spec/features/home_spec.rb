# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

RSpec.describe "Home page", chrome: true do
  before { create(:user, email: "BenJohnson@gmail.com", password: "123456") }
  before { Timecop.freeze(Time.local(2022, 1, 31, 13, 0)) }

  it "display the the app" do
    visit "/"
    find(:xpath, "//a/img[@alt='en']/..").click

    expect(page).to have_link "Log in"
    expect(page).to have_link "Sign up"
    expect(page).to have_content "Sign up"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"

    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"

    click_button "Sign in"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_link "Home"
    expect(page).to have_link "Create new order"
    expect(page).to have_link "Active order"
    expect(page).to have_link "History"
    expect(page).to have_link "Log out"

    click_link "Restaurants"
    click_link "New restaurant"
    fill_in "Title", with: "McDonalds"
    click_button "Save"

    click_link "Create new order"
    expect(page).to have_content "New order"
    expect(page).to have_content "Where"
    expect(page).to have_content "Check out time"
    expect(page).to have_field "Check"
    expect(page).to have_content "Body"
    expect(page).to have_field "Body"
    expect(page).to have_button "Create Order"
    expect(page).to have_link "Back"

    click_button "Create Order"
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Body is too short (minimum is 5 characters)"
    expect(page).to have_content "Check out time required and must be time"

    find("#order_restaurant_id option[value='1']").select_option
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
    expect(page).to have_content "Order was successfully created."
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "Some text"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_content "Status: Active"

    click_link "Create new order"
    click_link "Back"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "submit", visible: false

    click_link "Active order"
    find('.active-order-card').click

    expect(page).to have_content "Active orders"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "submit", visible: false

    click_link "Home"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "submit", visible: false

    find(".switch__checkbox-submit", visible: false).click
    click_link "History"
    expect(page).to have_content "McDonalds"

    click_link "Home"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "submit", visible: false

    click_button "Delete"
    expect(page).to have_content "Order was successfully destroyed."
    expect(page).to have_content "benjohnson@gmail.com"

    click_link "Create new order"
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "Some text"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_content "Status: Active"

    click_link "Log out"
    find(:xpath, "//a/img[@alt='en']/..").click

    expect(page).to have_link "Log in"
    expect(page).to have_link "Sign up"
    expect(page).to have_content "Sign in"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"

    click_link "Sign up"
    expect(page).to have_content "Sign up"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"
    expect(page).to have_field "Password confirmation"
    expect(page).to have_link "Sign up"

    fill_in "Email", with: "JonJohnson@gmail.com"
    fill_in "Password", with: "1234567"
    fill_in "Password confirmation", with: "1234567"

    click_button "Sign Up"
    expect(page).to have_content "All orders"
    expect(page).to have_content "jonjohnson@gmail.com"

    click_link "Active order"
    find('.active-order-card').click

    expect(page).to have_content "Home"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"

    click_link "Restaurants"
    click_link "New restaurant"
    fill_in "Title", with: "KFC"
    click_button "Save"

    click_link "Create new order"
    find("#order_restaurant_id option[value='2']").select_option
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
    expect(page).to have_content "KFC"
    expect(page).to have_content "Some text"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_content "Status: Active"

    click_link "Active order"
    expect(page).to have_content "Active orders"

    find("h2", text: "McDonalds").click
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"

    find("h2", text: "KFC").click
    expect(page).to have_content "KFC"
    expect(page).to have_content "jonjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "submit", visible: false

    click_link "Restaurants"
    expect(page).to have_button "Delete",disabled: true
  end
end
