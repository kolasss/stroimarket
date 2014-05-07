class Api::ServiceCategoriesController < ApplicationController
  respond_to :json

  def index
    respond_with ServiceCategory.json_tree(ServiceCategory.roots)
  end

  def show
    ids = ServiceCategory.find(params[:id]).self_and_children_ids
    services = Service.where(:service_category.in => ids)
    respond_with services,
      except: [:body, :service_category_id]
  end
end
