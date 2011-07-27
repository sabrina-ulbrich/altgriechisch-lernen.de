# this gemfile is only required for running the features/tests

source :rubygems

gem 'adva-core',       :path => File.expand_path('adva-core', '/Volumes/Users/sven/Development/projects/adva-cms2')
gem 'adva-blog',       :path => File.expand_path('adva-blog', '/Volumes/Users/sven/Development/projects/adva-cms2')
gem 'adva-static',     :path => File.expand_path('adva-static', '/Volumes/Users/sven/Development/projects/adva-cms2')
gem 'adva-user',       :path => File.expand_path('adva-user', '/Volumes/Users/sven/Development/projects/adva-cms2')
gem 'adva-markup',     :path => File.expand_path('adva-markup', '/Volumes/Users/sven/Development/projects/adva-cms2')
gem 'adva-categories', :path => File.expand_path('adva-categories', '/Volumes/Users/sven/Development/projects/adva-cms2')

# gem 'simple_nested_set', :path => '/Volumes/Users/sven/Development/projects/simple_nested_set'

group :development do
  gem 'tidy_ffi'
end

group :test do
  gem 'sqlite3-ruby', '1.2.5'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'webrat', '0.7.0'
  gem 'thor'
  gem 'ruby-debug'
  gem 'mocha'
  gem 'fakefs', :require => 'fakefs/safe'
  gem 'test_declarative'
  gem 'database_cleaner'
end
