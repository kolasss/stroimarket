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
      except: [:body, :_keywords, :cover_filename, :category_id, :manufacturer_id]

    # ids = Category.find(params[:id]).self_and_children_ids
    # products = Product.where(:category.in => ids).includes(:offers)
    # respond_with products,
    #   except: [:body, :_keywords, :cover_filename, :category_id, :manufacturer_id],
    #   methods: [:manufacturer_title]
  end
end
