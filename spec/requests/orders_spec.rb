# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :request do
  let(:attributes) do
    {
      check_out: "14:00",
      active: false,
      body: "MyText",
      restaurant_id: restaurant.id
    }
  end
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:restaurant) { create(:restaurant) }
  let(:order) { create(:order, restaurant: restaurant, user: user) }

  before { sign_in user }

  describe "#index" do
    let(:url) { orders_path }

    it_behaves_like "i18n"
    it "returns http success /index" do
      get url
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    let(:url) { order_path(order) }

    it_behaves_like "i18n"
    it "renders a successful response" do
      get url
      expect(response).to be_successful
    end
  end

  describe "#owner-show" do
    let(:url) { owner_show_order_path(order) }

    it_behaves_like "i18n"
    it "renders a successful response" do
      get url
      expect(response).to be_successful
    end
  end

  describe "#new" do
    let(:url) { new_order_path }

    it_behaves_like "i18n"
    it "renders a successful response" do
      get url
      expect(response).to be_successful
    end
  end

  describe "#active" do
    let(:url) { orders_active_path }

    it_behaves_like "i18n"
    it "renders a successful response" do
      get orders_active_url
      expect(response).to be_successful
    end
  end

  describe "#users paid" do
    let(:url) { paid_users_order_path(order) }

      it "renders a successful responser" do
        put url, params: { order: attributes}
        expect(response).to redirect_to(owner_show_order_path(order))
      end
  end

  describe "#history" do
    let(:url) { orders_history_path }

    it_behaves_like "i18n"
    it "renders a successful response" do
      get orders_history_url
      expect(response).to be_successful
    end
  end

  describe "#create" do
    context "with valid parameters" do
      it { expect { post orders_url, params: { order: attributes } }.to change { Order.count }.by(1) }
      it "redirects to the created order" do
        post orders_url, params: { order: attributes }
        expect(response).to redirect_to(order_url(Order.last))
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          check_out: "",
          body: ""
        }
      end

      it { expect { post orders_url, params: { order: attributes } }.to_not change(Order, :count) }
      it "renders a not successful response" do
        post orders_url, params: { order: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#destroy" do
    before { order }

    it { expect { delete order_url(order) }.to change(Order, :count).by(-1) }
    it "redirects to the articles list" do
      delete order_url(order)
      expect(response).to redirect_to(orders_url)
    end
  end
end
