# frozen_string_literal: true
require "capybara/cuprite"

Capybara.default_driver = Capybara.javascript_driver = :better_cuprite
Capybara.default_max_wait_time = 2
Capybara.register_driver :better_cuprite do |app|
  Capybara::Cuprite::Driver.new(app)
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    page.driver.resize_window(1920, 1080)
  end
  config.after(:each) do
    Capybara.use_default_driver
  end
end

# Uncomment the code below to use the Cuprite driver with a visible Chrome browser
# for local debugging of feature specs. This configuration will open the browser
# and allow interaction with the tests in real-time, which is useful for
# troubleshooting issues that may not be apparent in headless mode.
#
# Note: This setup is not suitable for CI environments as it requires a visible
# browser. Be sure to comment this code out before pushing to CI to avoid
# unnecessary browser launches and potential test failures.

# Capybara.register_driver :better_cuprite do |app|
#   Capybara::Cuprite::Driver.new(app,
#     **{
#       window_size: [1200, 800],
#       process_timeout: 10,
#       inspector: true,
#       browser: :chrome,
#       headless: false
#     })
# end
