class Api::StoresController < ApplicationController
  respond_to :json

  def index
    respond_with User.sellers.map(&:store_profile).compact
  end

  def show
    # ids = Category.find(params[:id]).self_and_children_ids
    # products = Product.where(:category.in => ids).includes(:offers)
    # respond_with products,
    #   except: [:body, :_keywords, :cover_filename, :category_id]
      # include: {
      #   offers: { only: [:price, :user_id] }
      # }

    # render json: products,
    #   # except: [:body_translations, :protected_content, :position],
    #   # include: {
    #   #   category: {only: [:id, :title_translations, :label]},
    #   #   status: {only: [:color, :title_translations]}
    #   # },
    #   cover_helper: method(cover.thumb.url)
  end
end
