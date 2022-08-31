# frozen_string_literal: true

module Internationalization
  extend ActiveSupport::Concern

  included do
    before_action :switch_locale

    private

    def switch_locale
      # I18n.locale = params[:locale] || session[:locale] || locale_from_header || I18n.default_locale
      session[:locale] = I18n.locale
    end

    def locale_from_header
      request.env.fetch("HTTP_ACCEPT_LANGUAGE", "").scan(/[a-z]{2}/).first
    end
  end
end
