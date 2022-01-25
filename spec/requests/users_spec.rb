require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = create(:user, email:"Bob@gmail.com",password:"password")
  end
  describe "GET #index" do
    it "returns http success" do
      get "/users/sign_in"
      sign_in @user
      expect(response).to have_http_status(:success)
    end
  end
end
