# frozen_string_literal: true

require "rails_helper"

RSpec.describe Order, type: :model do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password: "123456") }
  let(:restaurant) { create(:restaurant) }
  let(:order) { create(:order, restaurant: restaurant, user: user) }

  it { expect(order).to be_valid }

  it "is not valid body" do
    order = build(:order, user: user, body: "")
    expect(order).not_to be_valid
  end

  it "is not valid check out time" do
    order = build(:order, user: user, check_out: "")
    expect(order).not_to be_valid
  end
end
