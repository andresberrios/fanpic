source 'https://rubygems.org'

ruby '2.0.0'

# For Heroku support
gem 'rails_12factor', group: :production


# Make sure we use an updated bundler
gem 'bundler', '>= 1.8.4'
# Make sure we use an older sprockets to support angular-rails-templates
gem 'sprockets-rails', '>= 2.1.4'
gem 'sprockets', '< 3.0.0'

# To bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use MySQL as the database for Active Record
gem 'mysql2'

# Server
gem 'thin', require: false
gem 'rack-protection'


# Use Slim for templates
gem 'slim-rails'
# User Auth
gem 'devise'
gem 'cancancan', '~> 1.10'
# Manage application configuration
gem 'figaro'

# Add pagination to models
gem 'will_paginate', '~> 3.0.6'
# Responders gem to DRY up controllers
gem 'responders'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  # Annotate models with their attributes
  gem 'annotate'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', groups: [:development, :test]


group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.1.0'
end

# AngularJS CSFR protection support
gem 'angular_rails_csrf'
# Compile AngularJS templates
gem 'angular-rails-templates'

# Assets
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass', '~> 4.2.0'
source 'https://rails-assets.org' do
  gem 'rails-assets-lodash'
  gem 'rails-assets-moment'
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-touch'
  gem 'rails-assets-angular-bootstrap'
  gem 'rails-assets-angular-devise'
  gem 'rails-assets-angular-ui-router'
end
