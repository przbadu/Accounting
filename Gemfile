source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'

# accounting
gem 'plutus'

# API
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'

  # Testing framework
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'database_cleaner', '~> 1.6.0'
  gem 'airborne' # api testing helper methods
end

# code coverage
gem 'simplecov', :require => false, :group => :test

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
