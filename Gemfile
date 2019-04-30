source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.0'
gem 'pg'
# gem 'sqlite3', '1.3.13'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.0'
gem 'bcrypt', '3.1.12'
gem 'faker', '1.7.3'

gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass',          '3.3.7'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '3.9.1'
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '3.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.2.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.0.1'
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.7.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# ransack for search and filter
# gem 'ransack'


#jstree
gem 'bulma-rails'
gem 'jstreejs-rails', '3.3.5.0'
gem 'ancestry'


group :development, :test do
  gem 'database_cleaner', '1.4.1'
  gem "rspec-rails"
  # gem 'sqlite3', '1.3.13'
  gem "factory_bot_rails"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '9.0.6', platforms: :mri
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'fixture'
  gem 'email_spec'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '3.5.1'
  gem 'listen', '3.0.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'simplecov' #oh god
  gem 'awesome_print' # for display format in rails console
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters', '1.1.14'
  gem 'guard', '2.13.0'
  gem 'guard-minitest', '2.4.4'
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
end

group :production do
  # gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
