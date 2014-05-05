class Admin::ManufacturersController < AdminController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers = Manufacturer.all
    authorize AdminController
  end

  def show
  end

  def new
    @manufacturer = Manufacturer.new
    authorize AdminController
  end

  def edit
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    authorize AdminController

    if @manufacturer.save
      redirect_to admin_manufacturer_path(@manufacturer), notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    if @manufacturer.update(manufacturer_params)
      redirect_to admin_manufacturer_path(@manufacturer), notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @manufacturer.destroy
    redirect_to admin_manufacturers_path
  end

  private
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
      authorize AdminController
    end

    def manufacturer_params
      params.require(:manufacturer).permit(
        :title,
        category_ids: []
      )
    end
end
