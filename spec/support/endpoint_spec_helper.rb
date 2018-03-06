module EndpointSpecHelper
  def self.included(base)
    base.class_eval do
      let(:current_user) { User.new(admin: true) }

      subject do
        described_class.new(current_user: current_user)
      end
    end
  end
end
