class Api::StoresController < ApplicationController
  respond_to :json

  def index
    stores = User.sellers.map(&:store_profile).compact
    respond_with stores,
      methods: [:user_id]
  end

  def show
    products = User.find(params[:id]).products_for_catalog

    respond_with products
  end

  def services
    services = User.find(params[:id]).services

    respond_with services,
      except: [:_keywords, :service_category_id, :user_id],
      include: {
        service_category: {
          methods: [:slug],
          only: [
            :slug,
            :title
          ]
        }
      }
  end
end
