class Admin::ProductsController < AdminController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :set_category_for_product, only: [:custom_category_fields, :manufacturer_field]

  def index
    # if current_user.admin?
    #   @products = Product.all.page(params[:page])
    # else
    #   @products = current_user.products.page(params[:page])
    # end
    @products = Product.all.page(params[:page])
    authorize @products
  end

  def show
    @product = Product.includes(:offers).find(params[:id])
    authorize @product
  end

  def new
    if current_user.admin?
      @product = Product.new
    else
      @product = current_user.products.new
    end
    authorize @product
  end

  def edit
  end

  def create
    if current_user.admin?
      @product = Product.new(product_params)
    else
      @product = current_user.products.new(product_params)
    end
    authorize @product

    if @product.save
      redirect_to admin_product_path(@product), notice: 'Товар создан.'
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Товар обновлен.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  def custom_category_fields
    render partial: "custom_category_fields", locals: {category: @category, object: @product}
  end

  def manufacturer_field
    render partial: "manufacturer_field", locals: {category: @category, object: @product}
  end

  private
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    def set_category_for_product
      if current_user.admin?
        @product = Product.find_or_initialize_by(id: params[:object_id])
      else
        @product = current_user.products.find_or_initialize_by(id: params[:object_id])
      end
      authorize @product, :update?
      @category = Category.find(params[:category_id])
    end

    def product_params
      @category = Category.find(params[:product][:category_id])

      safe_attributes = [
        :title,
        :intro,
        :body,
        :category_id,
        :cover,
        :remove_cover,
        :manufacturer_id
      ]
      safe_attributes << @category.product_attributes.map(&:name)

      params.require(:product).permit(safe_attributes)
    end
end
