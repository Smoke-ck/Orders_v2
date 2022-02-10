# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, email: "Bob@gmail.com", password: "password") }

  describe "GET #index" do
    it "returns http success" do
      get "/users/sign_in"
      sign_in user
      expect(response).to have_http_status(:success)
    end
  end
end
