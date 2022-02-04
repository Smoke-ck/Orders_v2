# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include AuthenticateWithTwoFactor
  layout "login"
  prepend_before_action :authenticate_with_two_factor, if: :two_factor_enabled?, only: [:create], autofocus: true
end
