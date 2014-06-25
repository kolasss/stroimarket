class Api::ServicesController < ApplicationController
  respond_to :json

  def index
    services = Service.all
    respond_with services,
      except: [:body, :_keywords, :cover_filename],
      methods: [:store_title]
  end

  def show
    service = Service.find(params[:id])
    service.update_attribute(:views, service.views+1)
    respond_with service.as_json_for_catalog
  end
end
