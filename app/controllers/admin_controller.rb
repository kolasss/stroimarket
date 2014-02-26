class AdminController < ApplicationController
  after_action :verify_authorized
  def index
    authorize AdminController
  end
end
