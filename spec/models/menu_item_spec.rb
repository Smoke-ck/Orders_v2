require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }

  it { expect(menu_item).to be_valid }

  it "is not valid title" do
    menu_item = build(:menu_item, title: "")
    expect(menu_item).not_to be_valid
  end

  it "is not valid title" do
    menu_item = build(:menu_item, title: 4)
    expect(menu_item).not_to be_valid
  end

  it "is not valid title" do
    menu_item = build(:menu_item, title: "A")
    expect(menu_item).not_to be_valid
  end

  it "is not valid price" do
    menu_item = build(:menu_item, price: "")
    expect(menu_item).not_to be_valid
  end

  it "is not valid price" do
    menu_item = build(:menu_item, price: "55555.55")
    expect(menu_item).not_to be_valid
  end

end
