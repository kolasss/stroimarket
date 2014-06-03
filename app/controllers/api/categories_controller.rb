class Api::CategoriesController < ApplicationController
  respond_to :json

  def index
    respond_with Category.json_tree(Category.roots)
  end

  def show
    ids = Category.find(params[:id]).self_and_children_ids
    products = Product.where(:category.in => ids).includes(:offers)
    respond_with products,
      except: [:body, :_keywords, :cover_filename, :manufacturer_id],
      methods: [:manufacturer_title, :offers_count]
      # include: {
      #   offers: { only: [:price, :user_id] }
      # }

  end
end
