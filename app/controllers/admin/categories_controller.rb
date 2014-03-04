class Admin::CategoriesController < AdminController
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
      redirect_to admin_category_path(@category), notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_url
  end

  def update_position
    @category = Category.find(params[:id])
    authorize AdminController, :update?

    if params[:prev_id]
      @category.move_below(Category.find(params[:prev_id]))
    else
      # if params[:parent_id]
      #   @category.parent = Category.find(params[:parent_id])
      # else
      #   @category.parent = nil
      # end

       @category.parent = params[:parent_id] ? Category.find(params[:parent_id]) : nil

      if @category.save
        @category.move_to_top
      else
        render(json: @category.errors, status: :unprocessable_entity) and return
      end
    end

    render nothing: true
  end

  private
    def set_category
      @category = Category.find(params[:id])
      authorize AdminController
    end

    def category_params
      safe_attributes = [
        :title,
        :position,
        :parent_id,
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
