require 'rails_helper'

RSpec.describe "OrderItems", type: :request do
  let(:attributes) do
    {
      count: 2,
      order_id: order.id,
      menu_item_id: menu_item.id
    }
  end
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }
  let(:restaurant) { create(:restaurant) }
  let(:order) { create(:order, restaurant: restaurant, user: user) }
  let(:order_item) { create(:order_item, order: order, menu_item: menu_item, user: user) }
  let(:order_url) { order_path(order.id) }

  before { sign_in user }

  describe "#new" do
    it "renders a successful response" do
      get new_order_order_item_path(order.id)
      expect(response).to be_successful
    end
  end

  describe "#create" do
    let(:url) { order_order_items_path(order.id) }

    context "with valid parameters" do
      it { expect { post url, params: { order_item: attributes } }.to change { OrderItem.count }.by(1) }
      it "redirects to the order" do
        post url, params: { order_item: attributes  }
        expect(response).to redirect_to(order_url)
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          count: ""
        }
      end

      it { expect { post url, params: { order_item: attributes } }.to_not change(OrderItem, :count) }
      it "renders a not successful response" do
        post url, params: { order_item: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#edit" do
    it "renders a successful response" do
      get edit_order_item_path(order_item.id)
      expect(response).to be_successful
    end
  end

  describe "#update" do
    let(:url) { order_item_path(order_item.id) }

    context "with valid parameters" do
      let(:attributes) do
        {
          count: 3,
          order_id: order.id,
          menu_item_id: menu_item.id
        }
      end

      it { expect { patch url, params: { order_item: attributes } }.to change { OrderItem.count }.by(1) }
      it "redirects to the order" do
        patch url, params: { order_item: attributes }
        expect(response).to redirect_to(order_url)
      end
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          count: ""
        }
      end

      it "renders a not successful response" do
        patch url, params: { order_item: attributes }
        expect(response).not_to be(:success)
      end
    end
  end

  describe "#destroy" do
    before { order_item }
    let(:url) { order_item_path(order_item) }

    it { expect { delete url }.to change(OrderItem, :count).by(-1) }
    it "redirects to the order" do
      delete url
      expect(response).to redirect_to(order_url)
    end
  end
end
