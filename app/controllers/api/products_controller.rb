class Api::ProductsController < ApplicationController
  respond_to :json

  def show
    product = Product.find(params[:id])

    product.update_attribute(:views, product.views+1)

    respond_with product.as_json_for_catalog
  end

  def popular
    products = Product.desc(:views).limit(5)
    respond_with products,
      except: [:_id, :_keywords, :cover_filename]
  end
end
