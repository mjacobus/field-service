require 'machinist/active_record'
require 'faker'

Territory.blueprint do
  name { sn }
  description { "Description for #{sn}" }
end

Householder.blueprint do
  name { "Householder name #{sn}" }
  street_name { Faker::Address.street_name }
  house_number { sn }
  show { (sn%2) != 0 }
  territory
end

User.blueprint do
  name { "Householder name #{sn}" }
  email { "email#{sn}@email.com" }
  password { "123456" }
end
