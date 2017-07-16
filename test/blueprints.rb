require 'machinist/active_record'
require 'faker'

Territory.blueprint do
  name { sn }
  uuid { UniqueId.new }
  description { "Description for #{sn}" }
end

Householder.blueprint do
  name { "Householder name #{sn}" }
  uuid { UniqueId.new }
  street_name { Faker::Address.street_name }
  house_number { sn }
  show { sn%2 == 0 }
  notes { "Some notes #{sn}" }
  territory
end

User.blueprint do
  name { "Householder name #{sn}" }
  email { "email#{sn}@email.com" }
  password { '123456' }
end

Publisher.blueprint do
  name { "Householder name #{sn}" }
  email { "email#{sn}@email.com" }
  phone { '123456#{sn}' }
end
