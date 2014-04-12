class Api::ProductsController < ApplicationController
  respond_to :json

  def show
    product = Product.find(params[:id])
    respond_with product.as_json_for_catalog
  end
end
