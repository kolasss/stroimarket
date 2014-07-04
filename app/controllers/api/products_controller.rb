class Api::ProductsController < ApplicationController
  respond_to :json

  def show
    product = Product.find(params[:id])
    product.update_attribute(:views, product.views+1)
    respond_with product.as_json_for_catalog
  end

  def popular
    products = Product.desc(:views).limit(20)
    respond_with products,
      except: [:_keywords, :cover_filename]
  end
end
