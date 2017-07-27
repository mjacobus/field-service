# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :test do
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['test'].invoke
  end

  task coveralls: ['test:coverage']
end

namespace :csv do
  namespace :householders do
    desc 'import csv files from csv/to_import'
    task  import: [:environment] do
      importer = CsvImporter.new

      Dir['csv/to_import/householders_*.csv'].each do |file|
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
