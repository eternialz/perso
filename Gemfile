source 'https://rubygems.org'
ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use MongoDB as the database
gem 'mongoid', '~> 6.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# JQuery
gem "jquery-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Inline SVG instead of makin a new http request
gem 'inline_svg'

# Retry in case of error
gem 'retryable'

# HTTP Requests
gem 'httparty'

# Pagination plugin
gem 'kaminari'

# Cells
gem 'cells-rails'
gem 'cells-erb'

# Font-awesome
gem "font-awesome-rails"
# Reset CSS
gem 'normalize-rails'

# Markdown support
gem 'redcarpet'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'minitest-reporters'
  gem "pry"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Performance monitoring
  gem 'rack-mini-profiler'
  gem 'stackprof'
  gem 'flamegraph'
  gem 'bullet'
end

# Gzip for Heroku
gem 'heroku-deflater', :group => :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
