# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserSession", type: :request do
  let(:user) { create(:user, email:"Bob@gmail.com", password:"password") }
  let(:attributes) do
    {
      email: "Bob@gmail.com",
      password:"password"
    }
  end
  let(:url) { "/users/sign_in" }

  describe "sign_in user with disabled OTP" do

    before { user.save! }

    it "returns valid" do
      post url, params: { user: attributes }
      expect(flash[:notice]).to eq("Signed in successfully.")
    end

    it "returns invalid" do
      post url, params: { user: { email:"Bob@gmail.com", password:"" } }
      expect(flash[:alert]).to eq("Invalid Email or password.")
    end
  end

  describe "sign_in user with enabled OTP" do
    let(:user) { create(:user, email:"SecondBob@gmail.com", password:"password", otp_module:"enabled") }
    let(:attributes) do
      {
        email: "SecondBob@gmail.com",
        password:"password",
      }
    end

    before { user.save! }

    it "with valid parameters" do
      post url, params: { user: attributes }
      post url , params: { user: { otp_code_token: user.otp_code } }
      expect(flash[:alert]).to eq("You are already signed in.")
    end

    context "with invalid parameters" do
      let(:attributes) do
        {
          email: "SecondBob@gmail.com",
          password:"password"
        }
      end

      it "returns invalid token" do
        post url, params: { user: attributes }
        post url , params: { user: { otp_code_token: "123456" } }
        expect(flash[:alert]).to eq("Invalid two-factor code.")
      end
    end
    it_behaves_like "i18n"
  end

  describe "GET #edit" do
    let(:url) { "/users/edit" }
    before { sign_in user }

    it_behaves_like "i18n"

    it "returns http success" do
      get url
      expect(response).to have_http_status(:success)
    end
  end
end
