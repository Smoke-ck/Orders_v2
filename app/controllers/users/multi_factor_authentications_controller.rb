# frozen_string_literal: true

class Users::MultiFactorAuthenticationsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_user_to_new, only: :show
  before_action :redirect_user_to_show, only: :new

  def new
    current_user.otp_regenerate_secret
    current_user.save!
  end

  def create
    if current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      redirect_to edit_user_registration_path, notice: "Two Factor Authentication Enabled"
    else
      redirect_to multi_factor_authentication_path, alert: "Two Factor Authentication could not be enabled"
    end
  end

  def show; end

  def destroy
    if current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
      current_user.otp_module_disabled!
      redirect_to edit_user_registration_path, notice: "Two Factor Authentication Disabled"
    else
      redirect_to multi_factor_authentication_path, alert: "Two Factor Authentication could not be disabled"
    end
  end

  private

  def redirect_user_to_show
    redirect_to action: :show if current_user.otp_module_enabled?
  end

  def redirect_user_to_new
    redirect_to action: :new unless current_user.otp_module_enabled?
  end
end
