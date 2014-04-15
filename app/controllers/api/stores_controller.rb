class Api::StoresController < ApplicationController
  respond_to :json

  def index
    stores = User.sellers.map(&:store_profile).compact
    respond_with stores,
      include: {
        user: {only: [:_id]}
      }
  end

  def show
    products = User.find(params[:id]).products_for_catalog

    respond_with products
  end
end
