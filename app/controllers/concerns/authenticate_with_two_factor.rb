# frozen_string_literal: true

module AuthenticateWithTwoFactor
  extend ActiveSupport::Concern

  def authenticate_with_two_factor
    user = self.resource = find_user
    if user_params[:otp_code_token].present? && session[:otp_user_id]
      authenticate_user_with_two_factor(user)
    elsif user&.valid_password?(user_params[:password])
      prompt_for_two_factor(user)
    end
  end

  private

  def valid_attempt?(user)
    user.authenticate_otp(params[:user][:otp_code_token], drift: 60)
  end

  def prompt_for_two_factor(user)
    @user = user
    session[:otp_user_id] = user.id
    render "devise/sessions/two_factor"
  end

  def authenticate_user_with_two_factor(user)
    if valid_attempt?(user)
      session.delete(:otp_user_id)
      user.save!
      sign_in(user, event: :authentication)
    else
      flash.now[:alert] = "Invalid two-factor code."
      prompt_for_two_factor(user)
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me, :otp_code_token)
  end

  def find_user
    if session[:otp_user_id]
      User.find(session[:otp_user_id])
    elsif user_params[:email]
      User.find_by(email: user_params[:email].downcase)
    end
  end

  def two_factor_enabled?
    find_user&.otp_module == "enabled"
  end
end
