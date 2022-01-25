require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user, email: "BenJohns@gmail.com", password:"123456") }
  let(:order) { create(:order, user: user) }

  it {expect(order).to be_valid}

  it 'is not valid title' do
    order = build(:order, user: user, title:"")
    expect(order).not_to be_valid
  end

  it 'is not valid body' do
    order = build(:order, user: user,body:"")
    expect(order).not_to be_valid
  end

  it 'is not valid check out time' do
    order = build(:order, user: user, check_out:"")
    expect(order).not_to be_valid
  end
end
