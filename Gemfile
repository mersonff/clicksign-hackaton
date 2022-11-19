source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'hiredis'
gem 'jbuilder'
gem 'kredis'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'redis', '~> 4.0'
gem 'pg', '~> 1.1'
gem 'newrelic_rpm'
gem "sentry-ruby"
gem "sentry-rails"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Use JWT Authentication
gem 'api_guard'

# Load .env files
gem 'dotenv-rails', '~> 2.7.6'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem 'rack-cors'

gem 'aws-sdk-rails', '~> 3'

gem 'active_storage_validations'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.21.0'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'rubocop', '~> 1.36'
  gem 'rubocop-rails', '~> 2.16', '>= 2.16.1'
  gem 'rubocop-rspec', '~> 2.13', '>= 2.13.2'
  gem 'shoulda-matchers', '~> 5.1.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0.1'
end

group :development do
  gem 'spring'
end
