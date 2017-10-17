source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'

# accounting
gem 'plutus'

# JSON API
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  # Debuggers
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'

  # Testing Framework
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'database_cleaner', '~> 1.6.0'
  gem 'airborne'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# code coverage
gem 'simplecov', :require => false, :group => :test

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
