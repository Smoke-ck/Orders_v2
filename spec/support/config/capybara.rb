# frozen_string_literal: true
require "capybara/cuprite"

# JS_DRIVER = :selenium_chrome_headless

# Capybara.default_driver = :rack_test
# Capybara.javascript_driver = JS_DRIVER
Capybara.default_driver = Capybara.javascript_driver = :better_cuprite
Capybara.default_max_wait_time = 2
Capybara.register_driver :better_cuprite do |app|
  Capybara::Cuprite::Driver.new(app)
end

RSpec.configure do |config|
  # config.before(type: :feature) do
  #   Capybara.current_driver = ENV["CAPYBARA_BROWSER"]&.to_sym || :selenium_chrome
  # end

  config.before(:each, type: :feature) do |spec|
    page.driver.resize_window(1920, 1080)
  end
  config.after(:each) do
    Capybara.use_default_driver
  end
end
