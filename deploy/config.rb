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

set :whenever_environment, -> { fetch(:stage) }
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  namespace :assets do
    Rake::Task['deploy:assets:precompile'].clear_actions

    desc "Precompile assets on local machine and upload them to the server."
    task :precompile do
      run_locally do
        execute 'cd client; yarn run build; cd -'
        execute 'rm -f app/assets/javascripts/fs_client.js'
        execute 'rm -f app/assets/stylesheets/fs_client.css'
        execute 'cp client/build/static/js/main.js app/assets/javascripts/fs_client.js'
        execute 'cp client/build/static/css/main.css app/assets/stylesheets/fs_client.css'
      end

      run_locally do
        execute 'RAILS_ENV=production bundle exec rake assets:precompile'
      end

      on roles(:web) do
        within release_path do
          asset_full_path = "#{release_path}/public/#{fetch(:assets_prefix)}"
          asset_parent_path = File.dirname(asset_full_path)
          execute "mkdir -p #{asset_full_path}"
          upload! "./public/#{fetch(:assets_prefix)}", asset_parent_path, recursive: true
        end
      end

      run_locally do
        execute "rm -r ./public/#{fetch(:assets_prefix)}"
      end
    end
  end
end
