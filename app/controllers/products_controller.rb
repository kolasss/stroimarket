class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  after_action :verify_authorized, :except => [:index, :show, :custom_category_fields]

  def index
    if params[:query].present?
      @products = Product.full_text_search(params[:query])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.includes(:offers).find(params[:id])
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  def custom_category_fields
    @product = Product.find_or_initialize_by(id: params[:object_id])
    @category = Category.find(params[:category_id])

    render partial: "custom_category_fields", locals: {category: @category, object: @product}
  end

  private
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    def product_params
      @category = Category.find(params[:product][:category_id])

      safe_attributes = [
        :title,
        :cover,
        :intro,
        :body,
        :category_id,
        :cover,
        :remove_cover
      ]
      safe_attributes << @category.product_attributes.map(&:name)

      params.require(:product).permit(safe_attributes)
    end
end
