# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
  let(:attributes) do
    {
      title: "Some food",
      price: 99.99,
      restaurant_id: restaurant.id
    }
  end
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456", role: "admin") }
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }

  before { sign_in user }

  describe "#new" do
    it "renders a successful response" do
      get new_restaurant_menu_item_path(restaurant.id)
      expect(response).to be_successful
    end
  end

  describe "#create" do
    context "with valid parameters" do
      it { expect { post restaurant_menu_items_path(restaurant.id), params: { menu_item: attributes } }.to change { MenuItem.count }.by(1) }
      it "redirects to the restaurant" do
        post restaurant_menu_items_path(restaurant.id), params: { menu_item: attributes }
        expect(response).to redirect_to(restaurant_path(restaurant.id))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: "",
          price: 5555.55
        }
      end

      it { expect { post restaurant_menu_items_path(restaurant.id), params: { menu_item: attributes } }.to_not change(MenuItem, :count) }
      it "renders a not successful response" do
        post restaurant_menu_items_path(restaurant.id), params: { menu_item: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#edit" do
    it "renders a successful response" do
      get edit_menu_item_path(menu_item.id)
      expect(response).to be_successful
    end
  end

  describe "#update" do
    context "with valid parameters" do
      let(:attributes) do
        {
          title: "New food",
          price: 100,
          restaurant_id: restaurant.id
        }
      end

      it { expect { patch menu_item_path(menu_item.id), params: { menu_item: attributes } }.to change { MenuItem.count }.by(1) }
      it "redirects to the restaurant" do
        patch menu_item_path(menu_item.id), params: { menu_item: attributes }
        expect(response).to redirect_to(restaurant_path(restaurant.id))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: "",
          price: 5555.55
        }
      end

      it "renders a not successful response" do
        patch menu_item_path(menu_item.id), params: { menu_item: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#destroy" do
    before { menu_item }

    it { expect { delete menu_item_path(menu_item) }.to change(MenuItem, :count).by(-1) }
    it "redirects to the restaurant" do
      delete menu_item_path(menu_item)
      expect(response).to redirect_to(restaurant_path(restaurant.id))
    end
  end
end
