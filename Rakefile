# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :travis_ci do
  ENV['RAILS_ENV'] = 'test'
  ENV['COVERAGE'] = 'true'

  # Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['spec'].invoke
end

namespace :csv do
  namespace :householders do
    desc 'import csv files from csv/to_import/householders_*.csv'
    task  import: [:environment] do
      importer = CsvImporter.new

      Dir['csv/to_import/householders_*.csv'].each do |file|
        puts "Importing #{file}"
        importer.import(file)
        FileUtils.mv(file, 'csv/imported')
      end
    end

    desc 'export all'
    task :export_all, [:filename] => [:environment] do |_t, args|
      filename = args.fetch(:filename) do
        suffix = DatePath.new(prefix: 'export_housholders_', suffix: '.csv').to_s
        Rails.root.join('csv', 'exports', suffix)
      end

      file = Rails.root.join(filename)
      householders = Householder.ordered
      HouseholdersCsvExporter.new.export(householders).to_file(file)

      puts "Exported to #{file}"
    end
  end

  namespace :territory_assignments do
    desc 'import csv files from csv/to_import/territory_assignments_*.csv'
    task  import: [:environment] do
      importer = CsvImporter.new(
        filter: TerritoryAssignmentCsvFilter.new,
        importer: TerritoryAssignmentImporter.new
      )

      Dir['csv/to_import/territory_assignments_*.csv'].each do |file|
        puts "Importing #{file}"
        importer.import(file)
        FileUtils.mv(file, 'csv/imported')
      end
    end
  end
end

desc 'email backup files'
task email_backup: %i[environment] do
  files_to_backup = [
    'bkp/mysql_latest.sql',
    'bkp/housholders.csv'
  ]

  file = Rails.root.join(files_to_backup.last)

  if File.exist?(file)
    FileUtils.rm(file)
  end

  Rake::Task['mysql:dump_latest'].invoke(files_to_backup.last)
  Rake::Task['csv:householders:export_all'].invoke(files_to_backup.last)
  Rake::Task['backup:files'].invoke(*files_to_backup)
end

namespace :geolocation do
  desc 'update geolocations'
  task  update: [:environment] do
    Householder.all.each do |householder|
      begin
        householder.update_geolocation
        if householder.has_geolocation?
          householder.save!
        else
          puts "householder: #{householder} has no geolocation"
        end
      rescue => e
        puts e.message
      end
    end
  end
end

namespace :backup do
  desc 'performs backup'
  task :files, [] => [:environment] do |_t, args|
    files = args.extras.map do |filename|
      Rails.root.join(filename.strip).to_s
    end

    from = ENV.fetch('BACKUP_EMAIL_FROM').split(',').map(&:strip)

    strategy = Backup::Strategies::Email.new(
      recipients: User.where(admin: true).pluck(:email),
      from: from,
      subject: I18n.t('emails.backup.subject', app_env: Rails.env),
      body: I18n.t('emails.backup.body'),
    )

    Backup.new(files: files).perform(strategy: strategy)
  end
end

require 'koine/db_bkp'

Koine::Tasks::RailsMysqlDump.new do |t|
  t.task_name = 'mysql:dump'
  t.output_file = 'bkp/mysql_{timestamp}.sql'
end

Koine::Tasks::RailsMysqlDump.new do |t|
  t.task_name = 'mysql:dump_latest'
  t.output_file = 'bkp/mysql_latest.sql'
end
