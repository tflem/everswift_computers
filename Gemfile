source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'
gem 'rails',         '5.1.2'
gem 'bcrypt',        '3.1.11'
gem 'faker',         '1.7.3'
gem 'will_paginate', '3.1.5'
gem 'will_paginate-materialize'
gem 'puma',          '3.9.1'
gem 'sass-rails',    '5.0.6'
gem 'materialize-sass'
gem 'uglifier',      '3.2.0'
gem 'coffee-rails',  '4.2.2'
gem 'jquery-rails',  '4.3.1'
gem 'turbolinks',    '5.0.1'
gem 'jbuilder',      '2.7.0'
gem 'font-ionicons-rails'
gem 'pg', '0.20.0'

group :development, :test do
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
