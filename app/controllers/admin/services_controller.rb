class Admin::ServicesController < AdminController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.all
    authorize AdminController
  end

  def show
  end

  def new
    @service = Service.new
    authorize AdminController
  end

  def edit
  end

  def create
    @service = Service.new(service_params)
    authorize AdminController

    @service.user = current_user if @service.user.blank? and current_user.seller?

    if @service.save
      redirect_to admin_service_path(@service), notice: t(:created)
    else
      render action: 'new'
    end
  end

  def update
    if @service.update(service_params)
      redirect_to admin_service_path(@service), notice: t(:updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path
  end

  private
    def set_service
      @service = Service.find(params[:id])
      authorize AdminController
    end

    def service_params
      params.require(:service).permit(
        :title,
        :body,
        :service_category_id,
        :user_id
      )
    end
end
