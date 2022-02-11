# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MultiFactor", type: :request do

  let(:user) { create(:user, email:"Bob@gmail.com", password:"password") }
  let(:attributes) do
    {
      multi_factor_authentication: { otp_code_token:"" },
    }
  end
  let(:url) { multi_factor_authentication_path}

  before { sign_in user }

  describe "#new" do
    let(:url) { new_multi_factor_authentication_path }

    it_behaves_like "i18n"
    it "secret was changed" do
      get url
      expect { user.otp_regenerate_secret }.to change(user, :otp_secret_key)
    end
  end

  describe "#edit" do
    let(:url) { new_multi_factor_authentication_path }

    it_behaves_like "i18n"
    it "returns http success" do
      get url
      expect(response).to have_http_status(:success)
    end
  end

  context "with invalid parameters" do

    it_behaves_like "i18n"

    it "enable" do
      post url, params: attributes
      expect(flash[:alert]).to eq("Two Factor Authentication could not be enabled")
    end

    it "disable" do
      delete url, params: attributes
      expect(flash[:alert]).to eq("Two Factor Authentication could not be disabled")
    end
  end

  context "with valid parameters" do

    let(:attributes) do
      {
        multi_factor_authentication: { otp_code_token: user.otp_code },
      }
    end

    it "enable" do
      post url, params: attributes
      expect(flash[:notice]).to eq("Two Factor Authentication Enabled")
    end

    it "disable" do
      delete url, params: attributes
      expect(flash[:notice]).to eq("Two Factor Authentication Disabled")
    end
  end

  describe "redirect user if" do
    let(:url) { new_multi_factor_authentication_path }
    let(:user) { create(:user, email:"Bob@gmail.com", password:"password", otp_module:"enabled") }

    before { sign_in user }

    it "enabled OTP" do
      get url
      expect redirect_to(multi_factor_authentication_path)
    end
  end

  describe "redirect user if" do
    let(:url) { new_multi_factor_authentication_path }
    let(:user) { create(:user, email:"Bob@gmail.com", password:"password", otp_module:"disabled") }

    before { sign_in user }

    it "desabled OTP" do
      get url
      expect redirect_to(multi_factor_authentication_path)
    end
  end
end
