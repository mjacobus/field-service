require 'rails_helper'

RSpec.describe User do
  describe '#territories' do
    context 'when user is admin' do
      let(:user) { User.new(admin: true) }

      it 'returns all the territories' do
        territories = double(:territories)

        allow(Territory).to receive(:all).and_return(territories)

        expect(user.territories).to be territories
      end
    end

    context 'when user is not an admin' do
      let(:user) { User.make!(admin: false) }
      let(:publisher1) { Publisher.make! }
      let(:publisher2) { Publisher.make! }
      let(:territory1) { Territory.make!(responsible_id: publisher1.id) }
      let(:territory2) { Territory.make!(responsible_id: publisher2.id) }
      let(:territory3) { Territory.make! }

      before do
        UserPublisher.create!(user_id: user.id, publisher_id: publisher1.id)
        UserPublisher.create!(user_id: user.id, publisher_id: publisher2.id)

        territory1
        territory2
        territory3
      end

      it 'returns only the territories that the user is responsible for' do
        expect(user.territories).to eq([territory1, territory2])
      end
    end
  end
end
