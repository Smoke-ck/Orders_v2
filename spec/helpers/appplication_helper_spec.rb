require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:restaurant) { create(:restaurant) }
  let(:order) { create(:order, restaurant: restaurant, user: user) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }

  describe "errors" do
    it "should be order errors" do
      order = build(:order, user: user, body: "", restaurant: restaurant)
      order.validate
      expect(helper.form_error(order)).to include("Body is too short (minimum is 5 characters)")
    end

    it "should be restaurant errors" do
      restaurant = build(:restaurant, title: "")
      restaurant.validate
      expect(helper.form_error(restaurant)).to include("Title is too short (minimum is 2 characters)")
    end

    it "should be menu-items errors" do
      menu_item = build(:menu_item, title: "")
      menu_item.validate
      expect(helper.form_error(menu_item)).to include("Title is too short (minimum is 2 characters)")
    end
  end

  describe "flash" do
    it { expect(helper.prepend_flash).to eq("<turbo-stream action=\"replace\" target=\"flash\"><template></template></turbo-stream>") }
  end
end
