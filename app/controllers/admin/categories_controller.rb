class Admin::CategoriesController < AdminController
  # load_and_authorize_resource
  # skip_load_resource :only => [ :create ]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    authorize AdminController
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize AdminController
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    authorize AdminController

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.json { head :no_content }
    end
  end

  def update_position
    @category = Category.find(params[:id])
    authorize AdminController, :update?
    if params[:prev_id]
      @category.move_below(Category.find(params[:prev_id]))
    else
      if params[:parent_id]
        @category.parent = Category.find(params[:parent_id])
      else
        @category.parent = nil
      end

      if @category.save
        @category.move_to_top
      else
        render json: @category.errors, status: :unprocessable_entity
        return
      end
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      authorize AdminController
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
