class FrontendController < ApplicationController
  layout 'frontend'

  def index
    render text: :foo
  end
end
