# config valid only for current version of Capistrano
lock '3.8.1'

require 'dotenv'
Dotenv.load

set :application, ENV['APPLICATION_NAME']
set :repo_url, 'git@github.com:mjacobus/field-service.git'

if ENV['BRANCH']
  set :branch, ENV['BRANCH']
else
  ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
end

set :deploy_to, "/var/www/apps/#{fetch(:application)}"
set :chruby_ruby, 'ruby-2.4.0'
set :pty, true
set :keep_releases, 10
set :bundle_flags, '--deployment'

append :linked_files,
       'config/database.yml',
       'config/secrets.yml',
       '.env'

append :linked_dirs,
       'log',
       'csv',
       'bkp',
       'tmp/pids',
       'tmp/cache',
       'tmp/sockets',
       'public/system'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

namespace :geolocation do
  desc 'update geolocation'
  task :update do
    on roles(:app), in: :sequence, wait: 5 do
      # TODO: Fix
      # Your restart mechanism here, for example:
      within(current_path) do
        execute 'bundle exec rake', 'geolocation:update'
      end
    end
  end
end

namespace :log do
  desc 'display log'
  task :tail do
    on roles(:app), in: :sequence, wait: 5 do
      # TODO: Fix
      # Your restart mechanism here, for example:
      within(current_path) do
        execute 'tail', '-f', 'log/production.log'
      end
    end
  end
end

namespace :download do
  desc 'Last mysql backup'
  task :db do
    on roles(:mysql_dump), in: :sequence, wait: 5 do
      download! "#{shared_path}/bkp/mysql_latest.sql", "bkp/mysql_latest_#{fetch(:stage)}.sql"
    end
  end
end

# When the asset build is run in the server there is a memory error
# This is why the frontend assets need to be generated beforehand
# and then updloaded
desc 'generate the client javascripts'
task :generate_client_assets do
  media_files = []
  run_locally do
    execute 'yarn run build'

    media_files = Dir['client/build/static/media/**/*']
  end


  on roles(:app), in: :sequence, wait: 5 do
    files = {
      './client/build/static/js/main.js'   => 'app/assets/javascripts/fs_client.js',
      './client/build/static/css/main.css' => 'app/assets/stylesheets/fs_client.css'
    }

    files.each do |key, value|
      upload! key, "#{release_path}/#{value}"
    end

    media_files.each do |file|
      p file.inspect
      upload! file, "#{release_path}/app/assets/images/#{File.basename(file)}"
    end
  end
end

before 'deploy:assets:precompile', :generate_client_assets

set :whenever_environment, -> { fetch(:stage) }
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
