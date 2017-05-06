# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
  User.create(email: 'admin@example.com', password: 'admin', admin: true)
end

if ENV['INCLUDE_DEV_SEED'] == 'yes'
  require_relative "../test/blueprints.rb"

  1.upto(5) do |number|
    territory = Householder.make!.territory

    1.upto(30) do
      Householder.make! territory: territory
    end
  end
end
