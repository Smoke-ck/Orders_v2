# frozen_string_literal: true

require "rails_helper"

RSpec.describe AllOrderItemsPriceService do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }
  let(:order_items) do {
      16 => 5,
      17 => 7
    }
  end
  let(:menu_items) do [
      create(:menu_item, restaurant: restaurant, id: 16),
      create(:menu_item, restaurant: restaurant, id: 17, title: "Other item")
    ]
  end
  let(:items) {described_class.new order_items, menu_items}

  it { expect(items.call).to eq({ "Some item" => 5, "Other item" => 7, "All price" => 108}) }
end
