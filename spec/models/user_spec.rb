require 'rails_helper'

RSpec.describe User, type: :model do

    before(:all) do
        @user = create(:user)
    end
  
    it "is valid with valid attributes" do
        expect(@user).to be_valid
    end
  
    it "has a unique email" do
        user2 = build(:user, email: "test@gmail3451.com")
        expect(user2).to_not be_valid
    end
    
    it "is not valid without a password" do 
        user2 = build(:user, password: nil)
        expect(user2).to_not be_valid
    end

    it "is not valid without an email" do
        user2 = build(:user, email: nil)
        expect(user2).to_not be_valid
    end

    it "have orders" do
        order = build(:order)
        @user.orders << order
        expect(@user.orders.should == [order])
    end
end

