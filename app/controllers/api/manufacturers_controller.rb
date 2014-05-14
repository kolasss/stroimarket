class Api::ManufacturersController < ApplicationController
  respond_to :json

  def index
    manufacturers = Manufacturer.all
    respond_with manufacturers,
      only: [:title, :category_ids]
  end

  # def show
  #   manufacturer = Manufacturer.find(params[:id])
  #   respond_with manufacturer,
  #     except: [:_id, :_slugs, :cover_filename]
  # end
end
