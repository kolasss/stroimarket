class Admin::ServiceCategoriesController < AdminController
  include AdminPositionable

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = ServiceCategory.all
    authorize AdminController
  end

  def show
  end

  def new
    @category = ServiceCategory.new
    authorize AdminController
  end

  def edit
  end

  def create
    @category = ServiceCategory.new(category_params)
    authorize AdminController

    if @category.save
      redirect_to admin_service_categories_path, notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_service_categories_path, notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_service_categories_path
  end

  private
    def set_category
      @category = ServiceCategory.find(params[:id])
      authorize AdminController
    end

    def category_params
      safe_attributes = [
        :title,
        :parent_id
      ]
      params.require(:service_category).permit(*safe_attributes)
    end
end
