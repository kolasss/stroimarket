class Api::ServicesController < ApplicationController
  respond_to :json

  def show
    service = Service.find(params[:id])
    respond_with service.as_json_for_catalog
  end
end
