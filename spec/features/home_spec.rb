# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

RSpec.describe "Home page", chrome: true do
  before { create(:user, email: "BenJohnson@gmail.com", password: "123456") }
  before { Timecop.freeze(Time.local(2022, 1, 31, 13, 0)) }

  it "display the the app" do
    visit "/"
    expect(page).to have_link "Sign In"
    expect(page).to have_link "Registration"
    expect(page).to have_content "Sign up"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"

    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"

    click_button "Log in"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_link "Home"
    expect(page).to have_link "Create new order"
    expect(page).to have_link "Сurrent Order"
    expect(page).to have_link "History"
    expect(page).to have_link "Sign Out"

    click_link "Create new order"
    expect(page).to have_content "New Order"
    expect(page).to have_content "Where"
    expect(page).to have_field "Where"
    expect(page).to have_content "Check"
    expect(page).to have_field "Check"
    expect(page).to have_content "Body"
    expect(page).to have_field "Body"
    expect(page).to have_button "Create Order"
    expect(page).to have_link "Back"

    click_button "Create Order"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Title is too short (minimum is 2 characters)"
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Body is too short (minimum is 5 characters)"
    expect(page).to have_content "Check out required and must be in the format XX:XX"

    fill_in "Where", with: "McDonalds"
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
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
    expect(page).to have_button "Active"

    click_link "Сurrent Order"
    expect(page).to have_content "Current orders"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "Active"

    click_button "Active"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "Done"

    click_link "History"
    expect(page).to have_content "McDonalds"

    click_link "Home"
    expect(page).to have_content "All orders"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "Done"

    click_button "Delete"
    expect(page).to have_content "benjohnson@gmail.com"

    click_link "Create new order"
    fill_in "Where", with: "McDonalds"
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "Some text"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_content "Status: Active"

    click_link "Sign Out"
    expect(page).to have_link "Sign In"
    expect(page).to have_link "Registration"
    expect(page).to have_content "Sign up"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"

    click_link "Registration"
    expect(page).to have_content "Registration"
    expect(page).to have_field "Email"
    expect(page).to have_field "Password"
    expect(page).to have_field "Password confirmation"
    expect(page).to have_button "Sign up"

    fill_in "Email", with: "JonJohnson@gmail.com"
    fill_in "Password", with: "1234567"
    fill_in "Password confirmation", with: "1234567"

    click_button "Sign up"
    expect(page).to have_content "All orders"
    expect(page).to have_content "jonjohnson@gmail.com"

    click_link "Сurrent Order"
    expect(page).to have_content "Current orders"
    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"

    click_link "Create new order"
    fill_in "Where", with: "From..."
    fill_in "Check", with: "13:00"
    fill_in "Body", with: "Some text"
    check("Active")

    click_button "Create Order"
    expect(page).to have_content "From..."
    expect(page).to have_content "Some text"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_content "Status: Active"

    click_link "Сurrent Order"
    expect(page).to have_content "Current orders"

    expect(page).to have_content "McDonalds"
    expect(page).to have_content "benjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"

    expect(page).to have_content "From..."
    expect(page).to have_content "jonjohnson@gmail.com"
    expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
    expect(page).to have_link "Show"
    expect(page).to have_button "Delete"
    expect(page).to have_button "Active"
  end
end
