source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.1.1'
gem 'rails', '~> 4.1.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'

# group :doc do
#   # bundle exec rake doc:rails generates the API under doc/api.
#   gem 'sdoc', require: false
# end

gem 'mongoid', :git => 'https://github.com/mongoid/mongoid.git'
gem 'mongoid-tree', :git => 'https://github.com/benedikt/mongoid-tree.git', :branch => "mongoid-4.0", :require => 'mongoid/tree'
gem 'mongoid_slug'
gem 'mongoid_search', :git => 'https://github.com/mauriciozaffari/mongoid_search.git'

gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'mini_magick'
gem 'fog' #aws s3 support

gem 'haml-rails'

# gem 'cancan'
gem 'devise'
gem "pundit" #authorization

gem 'simple_form'


group :development do
  gem 'thin'
end

gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'kaminari' #paginator
gem "font-awesome-rails"

gem "nested_form"

gem 'angularjs-rails'
gem 'bootstrap-sass'
gem "autoprefixer-rails"

# gem 'oj'

group :production do
  gem 'rails_12factor' #for heroku
end

gem 'unicorn'
