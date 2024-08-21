# frozen_string_literal: true
require "rails_helper"
require "spec_helper"

RSpec.describe "Home page", chrome: true do
  let(:user) { create(:user, email: "BenJohnson@gmail.com", password: "123456") }
  let!(:restaurant1) { create(:restaurant, title: "McDonalds") }
  let!(:restaurant2) { create(:restaurant, title: "KFC") }

  before do
    Timecop.freeze(Time.local(2022, 1, 31, 13, 0))
    visit "/"
    find(:xpath, "//a/img[@alt='en']/..").click
  end

  describe "Login and Navigation" do
    it "logs in and navigates through the site" do
      expect(page).to have_link "Log in"
      expect(page).to have_link "Sign up"
      expect(page).to have_content "Sign up"
      expect(page).to have_field "Email"
      expect(page).to have_field "Password"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"

      expect(page).to have_content "All orders"
      expect(page).to have_content user.email
      expect(page).to have_link "Home"
      expect(page).to have_link "Create new order"
      expect(page).to have_link "Active order"
      expect(page).to have_link "History"
      expect(page).to have_link "Log out"
    end
  end

  describe "Restaurant management" do

    before do
      login(user)
    end

    it "creates and manages orders" do
      click_link "Restaurants"
      click_link "New restaurant"
      fill_in "Title", with: "Test"
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

      select restaurant1.title, from: "order_restaurant_id"
      fill_in "Check", with: "13:00"
      fill_in "Body", with: "Some text"
      check("Active")

      click_button "Create Order"
      expect(page).to have_content "Order was successfully created."
      expect(page).to have_content restaurant1.title

      click_link "Create new order"
      click_link "Back"
      expect(page).to have_content "All orders"
      expect(page).to have_content user.email
      expect(page).to have_content restaurant1.title
      expect(page).to have_link "Show"
      expect(page).to have_button "Delete"
      expect(page).to have_css('input.switch__onOff#demo')

      click_link "Active order"
      find('.active-order-card').click

      expect(page).to have_content "Active orders"
      expect(page).to have_content restaurant1.title
      expect(page).to have_content user.email
      expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
      expect(page).to have_link "Show"
      expect(page).to have_button "Delete"
      expect(page).to have_css('input.switch__onOff#demo')

      click_link "Home"
      expect(page).to have_content "All orders"
      expect(page).to have_content user.email
      expect(page).to have_content restaurant1.title
      expect(page).to have_link "Show"
      expect(page).to have_button "Delete"
      expect(page).to have_css('input.switch__onOff#demo')

      find('input.switch__onOff#demo').click
      click_link "History"
      expect(page).to have_content restaurant1.title

      click_link "Home"
      expect(page).to have_content "All orders"
      expect(page).to have_content user.email
      expect(page).to have_content restaurant1.title
      expect(page).to have_link "Show"
      expect(page).to have_button "Delete"
      expect(page).to have_css('input.switch__onOff#demo')

      click_button "Delete"
      expect(page).to have_content "Order was successfully destroyed."
      expect(page).to have_content user.email

      click_link "Create new order"
      fill_in "Check", with: "13:00"
      fill_in "Body", with: "Some text"
      check("Active")

      click_button "Create Order"
      expect(page).to have_content restaurant1.title
    end
  end

  describe "User registration and logout" do

    before do
      login(user)
    end

    it "signs up a new user and logs out" do
      click_link "Log out"
      find(:xpath, "//a/img[@alt='en']/..").click
      create(:order, restaurant: restaurant2, user: user, active: true)

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


      fill_in "Email", with: "jonjohnson@gmail.com"
      fill_in "Password", with: "1234567"
      fill_in "Password confirmation", with: "1234567"

      click_button "Sign Up"
      expect(page).to have_content "All orders"
      expect(page).to have_content "jonjohnson@gmail.com"

      click_link "Active order"
      find('.active-order-card').click

      expect(page).to have_content restaurant2.title
      expect(page).to have_content user.email
      expect(page).to have_content "Check out time: 2022-01-31 14:00:00 UTC"
    end
  end

  describe "Handling multiple restaurants" do

    before do
      login(user)
    end

    it "creates orders with different restaurants" do
      create(:order, restaurant: restaurant1, user: user, active: true)

      click_link "Restaurants"
      click_link "New restaurant"
      fill_in "Title", with: "Second Test"
      click_button "Save"

      click_link "Create new order"
      select restaurant2.title, from: "order_restaurant_id"
      fill_in "Check", with: "13:00"
      fill_in "Body", with: "Some text"
      check("Active")

      click_button "Create Order"
      expect(page).to have_content restaurant2.title

      click_link "Active order"
      expect(page).to have_content "Active orders"

      find("h2", text: restaurant1.title).click
      expect(page).to have_content restaurant1.title
      expect(page).to have_content user.email
      expect(page).to have_content "Check out time: 2022-01-31 14:00:00 UTC"

      find("h2", text: restaurant2.title).click
      expect(page).to have_content restaurant2.title
      expect(page).to have_content user.email
      expect(page).to have_content "Check out time: 2022-01-31 13:00:00 UTC"
      expect(page).to have_link "Show"
      expect(page).to have_button "Delete"
      expect(page).to have_css('input.switch__onOff#demo')

      click_link "Restaurants"
      expect(page).to have_button "Delete", disabled: true
    end
  end
end
