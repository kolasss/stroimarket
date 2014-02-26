class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:index, :show, :custom_category_fields]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def custom_category_fields
    @product = Product.find_or_initialize_by(id: params[:object_id])
    @category = Category.find(params[:category_id])

    render partial: "custom_category_fields", locals: {category: @category, object: @product}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      @category = Category.find(params[:product][:category_id])

      params.require(:product).permit(
        :title,
        :cover,
        :body,
        :category_id,
        :cover,
        :remove_cover
      ).tap do |whitelisted|
        whitelisted.update(params[:product].slice(*@category.product_attributes.map(&:name)))
      end
    end
end
