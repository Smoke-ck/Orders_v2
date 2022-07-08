require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }
  let(:order) { create(:order, restaurant: restaurant, user: user) }
  let(:order_item) { create(:order_item, order: order, menu_item: menu_item, user: user) }
  let(:second_order_item) { build(:order_item, order: order, menu_item: menu_item, user: user) }

  describe "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:order)}
    it { should belong_to(:menu_item)}
  end

  it { expect(order_item).to be_valid }
  it "is not presence count" do
    order_item = build(:order_item, order: order, menu_item: menu_item, user: user, count: "")
    expect(order_item).not_to be_valid
  end

  it "is user can't review a product more than once" do
    order_item = build(:order_item, order: order, menu_item: menu_item, user: user)
    order_item.save
    second_order_item = build(:order_item, order: order, menu_item: menu_item, user: user)
    expect{second_order_item.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
