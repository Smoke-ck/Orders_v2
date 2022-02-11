require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  let(:restaurant) { create(:restaurant) }

  it { expect(restaurant).to be_valid }

  it "is not valid body" do
    restaurant = build(:restaurant, title: "")
    expect(restaurant).not_to be_valid
  end

  it "is not valid title" do
    restaurant = build(:restaurant, title: 4)
    expect(restaurant).not_to be_valid
  end

  it "is not valid title" do
    restaurant = build(:restaurant, title: "A")
    expect(restaurant).not_to be_valid
  end
end
