class Admin::OffersController < AdminController
  before_action :set_product, only: [:new, :create, :edit]
  before_action :set_offer, only: [:edit, :update, :destroy]
  # after_action :verify_authorized

  def new
    @offer = @product.offers.new
    authorize @offer
  end

  def edit
  end

  def create
    @offer = @product.offers.new(offer_params)
    authorize @offer

    @offer.user = current_user if @offer.user.blank? and current_user.seller?

    if @offer.save
      redirect_to admin_product_path(@product), notice: 'Предожение создано.'
    else
      render action: 'new'
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to admin_product_path(@offer.product), notice: 'Цена обновлена.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @offer.destroy
    redirect_to admin_product_path(@offer.product)
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_offer
      @offer = Offer.find(params[:id])
      authorize @offer
    end

    def offer_params
      # params.require(:offer).permit(
      #   :price
      # )
      params.require(:offer).permit(*policy(@offer || Offer).permitted_attributes)
    end
end
