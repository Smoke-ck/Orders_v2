# require 'rails_helper'

# RSpec.describe Order, type: :model do
#   current_user = User.first_or_create!(email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
#   it 'has a title' do
#     order = build(:order, user: current_user)
#     expect(order).to be_valid
#   end
#   it 'has a body' do
#     order = build(:order, user: current_user)
#     expect(order).to be_valid
#   end
#   it 'is not valid title' do
#     order = build(:order, user: current_user, title:"")
#     expect(order).not_to be_valid
#   end
#   it 'is not valid body' do
#     order = build(:order, user: current_user,body:"")
#     expect(order).not_to be_valid
#   end
# end
