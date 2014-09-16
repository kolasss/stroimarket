class Api::ServicesController < ApplicationController
  respond_to :json

  def index
    services = Service.all
    respond_with services,
      except: [:body, :_keywords, :cover_filename, :user_id],
      include: {
        user: {
          only: [:store_profile],
          include: {
            store_profile: {
              only: [
                :slug,
                :name,
              ]
            }
          }
        }
      }
  end

  def show
    service = Service.find(params[:id])
    service.update_attribute(:views, service.views+1)
    respond_with service.as_json_for_catalog
  end
end
