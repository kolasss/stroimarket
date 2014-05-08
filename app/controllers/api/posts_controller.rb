class Api::PostsController < ApplicationController
  respond_to :json

  def index
    respond_with Post.all
  end

  # def show
  #   ids = Category.find(params[:id]).self_and_children_ids
  #   products = Product.where(:category.in => ids).includes(:offers)
  #   respond_with products,
  #     except: [:body, :_keywords, :cover_filename, :category_id]
  #     # include: {
  #     #   offers: { only: [:price, :user_id] }
  #     # }

  # end
end
