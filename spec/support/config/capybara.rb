# frozen_string_literal: true

JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :rack_test
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2
RSpec.configure do |config|
  config.before(type: :feature) do
    Capybara.current_driver = ENV["CAPYBARA_BROWSER"]&.to_sym || :selenium_chrome
  end

  config.after(:each) do
    Capybara.use_default_driver
  end
end
