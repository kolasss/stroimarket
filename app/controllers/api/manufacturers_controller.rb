class Api::ManufacturersController < ApplicationController
  respond_to :json

  def index
    manufacturers = Manufacturer.all
    respond_with manufacturers,
      except: [:_keywords]
  end

  def show
    products = Manufacturer.find(params[:id]).products
    respond_with products,
      except: [:body, :_keywords, :cover_filename, :manufacturer_id],
      methods: [:offers_count]
  end
end
