class CatalogController < ApplicationController
  # before_action :set_category, only: [:show]

  def index
    render layout: "home"
  end

  private
    # def set_category
    #   @category = Category.find(params[:id])
    #   authorize AdminController
    # end

end
