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

set :whenever_environment, -> { fetch(:stage) }
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
