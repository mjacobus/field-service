# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :travis_ci do
  ENV['COVERAGE'] = 'true'

  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['spec'].invoke

  exec 'yarn run test'
end

task 'spec:coverage' do
  ENV['COVERAGE'] = 'true'

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
    task export_all: [:environment] do
      householders = Householder.ordered
      file = DatePath.new(prefix: 'export_housholders_', suffix: '.csv').to_s
      file = Rails.root.join('csv', 'exports', file)
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

require 'koine/db_bkp'

Koine::Tasks::RailsMysqlDump.new do |t|
  t.task_name = 'mysql:dump'
  t.output_file = 'bkp/mysql_{timestamp}.sql'
end

Koine::Tasks::RailsMysqlDump.new do |t|
  t.task_name = 'mysql:dump_latest'
  t.output_file = 'bkp/mysql_latest.sql'
end
