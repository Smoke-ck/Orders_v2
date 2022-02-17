# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, email: "Bob@gmail.com", password: "password") }

  describe "GET #index" do
    let(:url) { "/users/sign_in" }

    it_behaves_like "i18n"

    it "returns http success" do
      get url
      sign_in user
      expect(response).to have_http_status(:success)
    end
  end
end
