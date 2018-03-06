module EndpointSpecHelper
  def self.included(base)
    base.class_eval do
      let(:current_user) { User.new(admin: true) }

      subject do
        described_class.new(current_user: current_user)
      end

      base.extend(ClassMethods)
    end
  end

  module ClassMethods
    def is_admin_endpoint
      it 'is an admin endpoint' do
        expect(subject).to be_a(Endpoints::AdminEndpoint)
        expect(subject.respond_to?(:perform_as_admin, false)).to be false
        expect(subject.respond_to?(:perform_as_admin, true)).to be true
      end
    end
  end
end
