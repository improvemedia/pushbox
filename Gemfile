# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.2"

gem "puma", "~> 3.7"

gem "activerecord-postgis-adapter"
gem "pg"
gem "sidekiq"

gem "dotenv-rails"
gem "enumerize"
gem "formtastic"
gem "memoist"
gem "slim"
gem "virtus"

group :development, :test do
  gem "pry-byebug"

  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :production do
  gem "unicorn"
end

group :development do
  gem "overcommit", require: false
  gem "rubocop",    require: false

  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem "web-console", ">= 3.3.0"
end

group :deploy do
  gem "mina",              require: false
  gem "mina-multi_server", require: false
  gem "mina-multistage",   require: false
  gem "mina-puma",         require: false
  gem "mina-unicorn",      require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
