# frozen_string_literal: true

module Api
  module ControllerSpecHelper
    def self.included(base)
      base.class_eval do
        let(:current_user) { User.new }
        let(:admin_user) { User.new(admin: true) }
      end
    end

    def mock_controller_rendering
      find_double = double(
        :find,
        first: [],
        formats: [],
        identifier: [],
        render: []
      )
      find_all_double = []

      allow_any_instance_of(Api::ApiController).to receive(:current_user) { current_user }

      allow_any_instance_of(ActionView::PathSet).to receive(:find) { find_double }
      allow_any_instance_of(ActionView::PathSet).to receive(:find_all) { find_all_double }
    end

    def expect_controller_to_perform_with(*args)
      sign_in_as(current_user)
      mock_controller_rendering
      expect_any_instance_of(Api::ApiController).to receive(:perform_with).with(*args)
    end

    def sign_in_as_admin
      sign_in_as(User.new(admin: true))
    end
  end
end
