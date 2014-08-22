source 'https://rubygems.org'

ruby '2.1.1'
gem 'rails', '~> 4.1.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

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
  gem 'rails-dev-tweaks', '~> 1.1'
end

gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

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
