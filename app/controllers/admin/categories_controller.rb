class Admin::CategoriesController < AdminController
  include AdminPositionable

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    authorize AdminController
  end

  def show
  end

  def new
    @category = Category.new
    authorize AdminController
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    authorize AdminController

    if @category.save
      redirect_to admin_categories_path, notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
      authorize AdminController
    end

    def category_params
      safe_attributes = [
        :title,
        :show_on_main,
        :parent_id,
        :background,
        :remove_background,
        product_attributes_attributes:
        [
          :id,
          :_destroy,
          :title,
          :type,
          :unit
        ]
      ]
      params.require(:category).permit(*safe_attributes)
    end
end
