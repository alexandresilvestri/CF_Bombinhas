source "https://rubygems.org"

gem "rails", "~> 8.1.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "rspec-rails"
gem "tailwindcss-rails", "~> 4.4"
gem "discard", "~> 1.4"
gem "devise", "~> 5.0"
gem "image_processing", "~> 1.2"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "pry-byebug", "~> 3.12"
end

group :development do
  gem "web-console"
  gem "hotwire-spark"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
