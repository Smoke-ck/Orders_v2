# frozen_string_literal: true

module Helpers
  module Authentication
    def login(user, password = user.password)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
