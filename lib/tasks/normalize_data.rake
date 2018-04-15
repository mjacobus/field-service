namespace :app do
  task :normalize_data => :environment do
    puts "Updating #{Householder.count} householders"

    Householder.find_each do |householder|
      householder.house_number = householder.house_number
      householder.street_name = householder.street_name
      householder.save!
      print "."
    end

    puts  "done"
  end
end
