class Api::CategoriesController < ApplicationController
  respond_to :json

  def index
    # respond_with Category.all
    respond_with Category.json_tree(Category.roots)
  end

  def show
    ids = Category.find(params[:id]).self_and_children_ids
    products = Product.where(:category.in => ids)
    respond_with products
    # render json: products,
    #   # except: [:body_translations, :protected_content, :position],
    #   # include: {
    #   #   category: {only: [:id, :title_translations, :label]},
    #   #   status: {only: [:color, :title_translations]}
    #   # },
    #   cover_helper: method(cover.thumb.url)
  end
end
