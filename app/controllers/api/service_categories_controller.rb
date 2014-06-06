class Api::ServiceCategoriesController < ApplicationController
  respond_to :json

  def index
    respond_with ServiceCategory.all,
      only: [:_id, :title, :slug],
      methods: [:slug]
  end
end
