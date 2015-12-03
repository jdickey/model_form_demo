source 'https://rubygems.org'

# Security enhancement, killing 'github:' MITM attacks.
# See https://sikac.hu/secure-your-github-sources-in-your-gemfile-f99784015200
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com:#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use postgresql as the database for Sequel
gem 'pg', '~> 0.18'
gem 'sequel', '~> 4.24'
# gem 'sequel_pg', '~> 1.6'
gem 'sequel-rails', '~> 0.9'
gem 'factory_girl_rails', '~> 4.5'
gem 'database_cleaner', '~> 1.4'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Chamber for securable configuration
gem 'chamber', '~> 2.8'

# Use Fortitude for views as code
gem 'fortitude', '~> 0.9'

# SemanticLogger: a *much* more capable (and compatible) logger.
gem 'rails_semantic_logger', '~> 1.7'

# Use Thin as our Rack server
gem 'thin', '1.6.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # NOTE: 'pry-byebug' 3.2 depends on 'byebug' being '~> 5.0' :-(
  # gem 'byebug', '~> 6.0'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'dotenv-rails', '~> 2.0'
  gem 'pry-rails', '~> 0.3'
  gem 'pry-byebug', '~> 3.2'
  gem 'pry-doc', '~> 0.8'
  gem 'awesome_print', '~> 1.6'
  gem 'faker', '~> 1.4'
  gem 'ox', '~> 2.2'
end

group :test do
  gem 'minitest-rails-capybara', '~> 2.1'
  gem 'minitest-matchers', '~> 1.4'
  gem 'minitest-reporters', '~> 1.0'
  gem 'minitest-fail-fast', '~> 0.1'
  gem 'selenium-webdriver', '~> 2.47'
  # gem 'capybara-webkit', '~> 1.6'
  gem 'poltergeist', '~> 1.6'
end

group :test, :quality do
  # Install Brakeman into your system Gem repository, not here.
  # gem 'brakeman', require: false
  gem 'churn', '~> 1.0', require: false
  gem 'coveralls', '~> 0.8', require: false
  gem 'codeclimate-test-reporter', '~> 0.4', require: false
  gem 'flay', '~> 2.6', require: false
  gem 'flog', '>= 4.3.2', require: false
  gem 'reek', '~> 3.0', require: false
  gem 'rubocop', '~> 0.33', require: false
  gem 'simplecov', '~> 0.10', require: false

  gem 'parser', '~> 2.2', require: false
  gem 'ruby2ruby', '~> 2.2', require: false # required for diff output from 'flay'
end
