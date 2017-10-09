source 'https://rubygems.org'

gem 'capistrano'
gem 'capistrano-bundler'
gem 'capistrano-chruby'
gem 'capistrano-rails'
gem 'clearance', '~>1.14.1'
gem 'dotenv-rails'
gem 'foundation-icons-sass-rails'
gem 'foundation-rails'
gem 'koine-csv', '~> 0.2.1'
gem 'koine-google_maps_client'
gem 'koine-db_bkp', '~> 0.1.1'
gem 'object_comparator'
gem 'pg'
gem 'simple_form', '~> 3.5'
gem 'sprockets'
gem 'sprockets-es6'
gem 'unicorn'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binpath'
gem 'whenever', require: false
gem 'rack-cors', require: 'rack/cors'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'sqlite3'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'awesome_print'
  gem 'byebug', platform: :mri
  gem 'rubocop'
  gem 'reek'
  gem 'rspec-rails', '~> 3.6'
  gem 'spring-commands-rspec'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'database_cleaner', '~>1.5'
  gem 'faker'
  gem 'machinist', '~>2.0'
  gem 'minitest-around', '~>0.3'
  gem 'minitest-rg'
  gem 'minitest-spec-rails'
  gem 'mocha'
  gem 'poltergeist'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'shoulda', '~>3.5'
  gem 'shoulda-context', '~>1.2'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
