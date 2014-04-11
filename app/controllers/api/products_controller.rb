class Api::ProductsController < ApplicationController
  respond_to :json

  def show
    product = Product.find(params[:id])
    respond_with product,
      include: {
        category: {
          methods: [:slug],
          only: [:slug]
        }
      }
  end
end
