source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# зависим от рельсов 5.1.*
gem 'rails', '~> 5.1.4'

# легче запускает ваше приложение Rails
gem 'rails_12factor'

# используй гем Uglifier для сжатия ресурсов JavaScript
gem 'uglifier'

# используй гем puma в качестве сервера приложений
gem 'puma', '~> 3.7'

# гем recaptcha для защиты веб-сайтов от интернет-ботов
gem "recaptcha", require: "recaptcha/rails"

group :production do
  # гем базы данных на продакшн сервере heroku
  gem 'pg'
end

group :development, :test do
  # гем для работы с sqlite3
  gem 'sqlite3'

  # вызовите гем 'byebug' в любом месте кода, чтобы остановить выполнение и получить консоль отладчика
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # доступ к консоли IRB на страницах исключений или с помощью <% = console%> в любом месте кода
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
