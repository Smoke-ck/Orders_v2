# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :request do
  let(:attributes) do
    {
      title: "A Order Title",
      check_out: "14:00",
      active: false,
      body: "MyText"
    }
  end
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:order) { create(:order, user: user) }

  before { sign_in user }

  describe "#index" do
    it "returns http success /index" do
      get orders_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "renders a successful response" do
      get orders_url(order)
      expect(response).to be_successful
    end
  end

  describe "#new" do
    it "renders a successful response" do
      get new_order_url
      expect(response).to be_successful
    end
  end

  describe "#active" do
    it "renders a successful response" do
      get orders_active_url
      expect(response).to be_successful
    end
  end

  describe "#history" do
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
          title: "",
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
