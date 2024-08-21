# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe "Home page", chrome: true do
  let(:user) { create(:user, email: "BenJohnson@gmail.com", password: "123456") }
  let!(:restaurant) { create(:restaurant)}
  let!(:menu_item) { create(:menu_item, restaurant: restaurant) }

  before do
    login(user)
    find(:xpath, "//a/img[@alt='en']/..").click
    visit "/restaurants"
  end

  describe "Restaurant management flow" do
    before do
      expect(page).to have_content "All restaurants"
      expect(page).to have_link "New restaurant"
    end

    context "when creating a restaurant" do
      it "allows creating a new restaurant" do
        click_link "New restaurant"
        expect(page).to have_content "All restaurants"
        expect(page).to have_field "Title"
        expect(page).to have_button "Save"

        fill_in "Title", with: "McDonalds"
        click_button "Save"

        expect(page).to have_content "Restaurant was successfully created."
        expect(page).to have_content "McDonalds"
        expect(page).to have_link "Show"
        expect(page).to have_link "Edit"
        expect(page).to have_button "Delete"
      end
    end

    context "when editing a restaurant" do
      before do
        click_link "Restaurants"
        click_link "Edit"
      end

      it "allows editing the restaurant title" do
        expect(page).to have_field "Title"
        expect(page).to have_button "Save"

        fill_in "Title", with: "McDonaldsNew"
        click_button "Save"

        expect(page).to have_content "Restaurant was successfully edited."
        expect(page).to have_content "McDonaldsNew"
        expect(page).to have_link "Show"
        expect(page).to have_link "Edit"
        expect(page).to have_button "Delete"
      end
    end

    context "when adding items to a restaurant" do
      before do
        click_link "Show"
      end

      it "validates and creates new items" do
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
        expect(page).to have_content "Burger"
        expect(page).to have_content "Price: 55.55"
        expect(page).to have_link "Edit"
        expect(page).to have_button "Delete"
      end

      it "allows editing and deleting items" do
        click_link "Edit"
        fill_in "Title", with: "New Burger"
        fill_in "Price", with: "10.10"

        click_button "Save"
        expect(page).to have_content "Item was successfully edited."
        expect(page).to have_content "New Burger"

        click_button "Delete"
        expect(page).to have_content "Item was successfully destroyed."
      end

      it "allows adding multiple items" do
        click_link "Add item"
        fill_in "Title", with: "Burger"
        fill_in "Price", with: "55.55"
        click_button "Save"

        click_link "Add item"
        fill_in "Title", with: "Some Burger"
        fill_in "Price", with: "75.56"
        click_button "Save"

        expect(page).to have_content "Item was successfully created."
        expect(page).to have_content "Burger"
        expect(page).to have_content "Price: 55.55"
        expect(page).to have_content "Some Burger"
        expect(page).to have_content "Price: 75.56"
      end
    end

    context "when deleting a restaurant" do
      it "allows deleting a restaurant" do
        click_button "Delete"
        expect(page).to have_content "Restaurant was successfully destroyed."
      end
    end

    context "when creating another restaurant" do
      it "allows creating additional restaurants" do
        click_link "New restaurant"
        fill_in "Title", with: "McDonalds"
        click_button "Save"

        click_link "New restaurant"
        fill_in "Title", with: "KFC"
        click_button "Save"

        expect(page).to have_content "Restaurant was successfully created."
        click_link "Restaurants"
        expect(page).to have_content "McDonalds"
        expect(page).to have_content "KFC"
        expect(page).to have_link "Show"
        expect(page).to have_link "Edit"
        expect(page).to have_button "Delete"
      end
    end
  end
end
