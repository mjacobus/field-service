require 'rails_helper'

RSpec.describe UserPublisher do
  it 'belongs to user and publisher' do
    UserPublisher.create!(user: User.make!, publisher: Publisher.make!)
  end
end
