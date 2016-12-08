class AuthenticatedController < ApplicationController
  before_action :require_login
end
