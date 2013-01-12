source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'oauth2'
gem 'bootstrap-sass', '2.0.0'
gem 'therubyracer', :platform => :ruby
gem 'populator'
gem 'faker'
gem 'rest-client', '~> 1.6.7'
gem 'validates_timeliness', '~> 3.0'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "active_model_serializers", git: "git://github.com/rails-api/active_model_serializers.git"
# Changes for robin
# gem 'thin', "1.3.1"
# gem "eventmachine", "1.0.0.rc.1"
gem "update_only_changed_attributes", git: "git://github.com/MRudolph/update_only_changed_attributes.git"
gem 'rack-cors', :require => 'rack/cors'

# Server and production
  gem 'thin','1.5.0'

group :development do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.9.0'
  gem 'bcrypt-ruby', '3.0.1'
  gem 'annotate', '~> 2.4.1.beta'
  gem 'nifty-generators'
  gem 'pry-rails'

end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end


group :test do
  gem 'capybara', '1.1.2'
  gem 'rspec-rails', '2.9.0'
  gem 'factory_girl_rails', '~> 3.2.0'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem "json_spec", "~> 1.0.3"
end

group :production do
  gem "mysql2", "~> 0.3.11"
  # gem "pg", "~> 0.13.2"
end
# For Thin in Deployment
gem 'execjs'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
