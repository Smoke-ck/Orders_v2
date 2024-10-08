# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "cssbundling-rails", "~> 1.0"
gem "jsbundling-rails", "~> 1.0"
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem "active_model_otp"
gem "devise"
gem "rails-i18n"
gem "rqrcode_png", git: "https://github.com/DCarper/rqrcode_png.git"
gem "sass-rails"
gem "slim"

group :development, :test do
  gem "database_cleaner"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "scss-lint", require: false
  gem "shoulda-matchers"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  # gem "github_workflow", git: "https://github.com/daisybill/github_workflow.git", ref: "d4e327d8d30f2ce36036d75c75f0e38d96f5d961"
  gem "web-console"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "cuprite"
  gem "selenium-webdriver"
  gem "timecop"
  gem "webdrivers"
end
