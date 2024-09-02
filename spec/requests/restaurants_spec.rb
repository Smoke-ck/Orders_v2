# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let(:attributes) do
    {
      title: "KFC"
    }
  end
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456", role: "admin") }
  let(:restaurant) { create(:restaurant) }

  before { sign_in user }

  describe "#index" do
    it "returns http success /index" do
      get restaurants_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "renders a successful response" do
      get restaurants_path(restaurant)
      expect(response).to be_successful
    end
  end

  describe "#new" do
    it "renders a successful response" do
      get new_restaurant_path
      expect(response).to be_successful
    end
  end

  describe "#create" do
    context "with valid parameters" do
      it { expect { post restaurants_path, params: { restaurant: attributes } }.to change { Restaurant.count }.by(1) }
      it "redirects to the created restaurant" do
        post restaurants_path, params: { restaurant: attributes }
        expect(response).to redirect_to(restaurants_path)
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: ""
        }
      end

      it { expect { post restaurants_path, params: { restaurant: attributes } }.to_not change(Restaurant, :count) }
      it "renders a not successful response" do
        post restaurants_path, params: { restaurant: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#edit" do
    it "renders a successful response" do
      get edit_restaurant_path(restaurant.id)
      expect(response).to be_successful
    end
  end

  describe "#update" do
    context "with valid parameters" do
      let(:attributes) do
        {
          title: "New restaurant"
        }
      end

      it { expect { patch restaurant_path(restaurant.id), params: { restaurant: attributes } }.to change { Restaurant.count }.by(1) }
      it "redirects to the edited restaurant" do
        patch restaurant_path(restaurant.id), params: { restaurant: attributes }
        expect(response).to redirect_to(restaurants_path)
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          title: ""
        }
      end

      it "renders a not successful response" do
        patch restaurant_path(restaurant.id), params: { restaurant: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#destroy" do
    before { restaurant }

    it { expect { delete restaurant_path(restaurant) }.to change(Restaurant, :count).by(-1) }
    it "redirects to the restaurants list" do
      delete restaurant_path(restaurant)
      expect(response).to redirect_to(restaurants_path)
    end
  end
end
