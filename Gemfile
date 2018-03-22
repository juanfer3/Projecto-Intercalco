
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails'#, '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

end

group :production do
  gem 'pg', '~> 0.20'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


gem 'bootstrap', '~> 4.0.0.beta2.1'

gem 'bootstrap-datepicker-rails'

gem "select2-rails"

gem 'ionicons-rails'


gem 'popper_js', '~> 1.12.3'

gem "jquery-ui-rails"
gem 'jquery-rails'
gem 'bootstrap-datepicker-rails'
gem 'momentjs-rails'
gem "font-awesome-rails"

gem 'rails_layout'

gem "table_print"

gem 'will_paginate', github: 'jonatack/will_paginate'
gem 'will_paginate-bootstrap4'
gem 'simple_form'

gem 'devise'

gem 'devise-bootstrap-views'
gem 'devise-i18n'
#cancan Autorización
gem 'cancancan'

gem 'toastr-rails'
gem "font-awesome-rails"

gem 'best_in_place'

#para exportar a excel
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: '776037c0fc799bb09da8c9ea47980bd3bf296874'
gem 'axlsx_rails'

gem 'monetize'

#para exportar a excel
gem 'roo'
gem 'roo-xls'

gem 'sprockets_better_errors'

#para Exportar A PDF
gem 'wicked_pdf'
gem 'wkhtmltopdf-heroku'
gem 'wkhtmltopdf-binary'

#buscadores
gem 'ransack'
#gem 'ransack', github: 'activerecord-hackery/ransack'

gem 'colorize'

gem 'bootstrap-popover-rails', '~> 0.1.0'
gem 'bootstrap-tooltip-rails'


#gem combobox select
gem "selectize-rails"

#gem spinjs load page
gem 'spinjs-rails'
