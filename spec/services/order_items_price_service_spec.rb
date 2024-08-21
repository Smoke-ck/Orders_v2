# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrderItemsPriceService do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:other_user) { create(:user, email: "OtherBenJohns@gmail.com", password: "1234567") }
  let(:order) { create(:order, restaurant: restaurant, user: user) }
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant, id: 1, title: "Some food") }
  let(:order_items) do [
    create(:order_item, order: order, menu_item: menu_item, user: user),
    create(:order_item, order: order, menu_item: menu_item, user: other_user, count: 2)
  ]
  end
  let(:items) {described_class.new order_items.group_by(&:user_id)}

  it { expect(items.call).to eq({ user.id => 9, other_user.id => 18 }) }
end
