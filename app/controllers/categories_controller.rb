class CategoriesController < ApplicationController
  # before_action :set_category, only: [:show]

  def index
    @categories = Category.all
    authorize @categories
  end

  def show
    @category = Category.includes(:products).find(params[:id])
    authorize @category
  end

  private
    # def set_category
    #   @category = Category.find(params[:id])
    #   authorize AdminController
    # end

end
