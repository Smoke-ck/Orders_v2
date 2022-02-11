# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe "Home page", chrome: true do
  let(:user) { build(:user, email: "BenJohnson@gmail.com", password:"123456") }

  before { user.save! }
  it "display the the app" do
    visit "/"
    find(:xpath, "//a/img[@alt='en']/..").click
    fill_in "Email", with: "BenJohnson@gmail.com"
    fill_in "Password", with: "123456"
    click_button "Sign in"

    click_link "Restaurants"
    expect(page).to have_content "All restaurants"
    expect(page).to have_link "New restaurant"

    click_link "New restaurant"
    expect(page).to have_content "New Restaurant"
    expect(page).to have_field "Title"
    expect(page).to have_button "Save"
    fill_in "Title", with: "McDonalds"
    click_button "Save"

    expect(page).to have_content "Restaurant was successfully created."
    expect(page).to have_content "All restaurants"
    expect(page).to have_link "New restaurant"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_link "Edit"
    expect(page).to have_button "Delete"

    click_link "Edit"
    expect(page).to have_field "Title"
    expect(page).to have_button "Save"
    fill_in "Title", with: "McDonaldsNew"
    click_button "Save"

    expect(page).to have_content "Restaurant was successfully edited."
    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Show"
    expect(page).to have_link "Edit"
    expect(page).to have_button "Delete"

    click_link "Show"

    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Add item"
    click_link "Add item"

    expect(page).to have_field "Title"
    expect(page).to have_field "Price"
    expect(page).to have_button "Save"
    click_button "Save"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Title is too short (minimum is 2 characters)"
    expect(page).to have_content "Price can't be blank"

    fill_in "Title", with: "Burger"
    fill_in "Price", with: "5330.55"
    click_button "Save"
    expect(page).to have_content "Price should be in the format is XXX.XX"
    fill_in "Price", with: "55.55"

    click_button "Save"
    expect(page).to have_content "Item was successfully created."
    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Add item"
    expect(page).to have_content "Burger"
    expect(page).to have_content "Price: 55.55"

    expect(page).to have_link "Edit"
    expect(page).to have_button "Delete"

    click_link "Edit"

    expect(page).to have_field "Title"
    expect(page).to have_field "Price"
    expect(page).to have_button "Save"
    fill_in "Title", with: "New Burger"
    click_button "Save"

    expect(page).to have_content "Item was successfully edited."
    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Add item"
    expect(page).to have_content "New Burger"
    click_button "Delete"

    expect(page).to have_content "Item was successfully destroyed."
    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Add item"
    click_link "Add item"

    fill_in "Title", with: "Burger"
    fill_in "Price", with: "55.55"
    click_button "Save"
    click_link "Add item"

    fill_in "Title", with: "Some Burger"
    fill_in "Price", with: "75.56"
    click_button "Save"

    expect(page).to have_content "Item was successfully created."
    expect(page).to have_content "McDonaldsNew"
    expect(page).to have_link "Add item"
    expect(page).to have_content "Burger"
    expect(page).to have_content "Price: 55.55"
    expect(page).to have_content "Some Burger"
    expect(page).to have_content "Price: 75.56"
    click_link "Restaurants"
    click_button "Delete"

    expect(page).to have_content "Restaurant was successfully destroyed."

    click_link "New restaurant"

    expect(page).to have_content "New Restaurant"
    expect(page).to have_field "Title"
    expect(page).to have_button "Save"
    fill_in "Title", with: "McDonalds"
    click_button "Save"

    click_link "New restaurant"

    expect(page).to have_content "New Restaurant"
    expect(page).to have_field "Title"
    expect(page).to have_button "Save"
    fill_in "Title", with: "KFC"
    click_button "Save"

    expect(page).to have_content "Restaurant was successfully created."
    expect(page).to have_content "All restaurants"
    expect(page).to have_link "New restaurant"
    expect(page).to have_content "McDonalds"
    expect(page).to have_link "Show"
    expect(page).to have_link "Edit"
    expect(page).to have_button "Delete"
    expect(page).to have_content "KFC"
    expect(page).to have_link "Show"
    expect(page).to have_link "Edit"
    expect(page).to have_button "Delete"
  end
end
