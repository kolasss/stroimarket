class Admin::ServicesController < AdminController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @services = Service.all.page(params[:page])
    else
      @services = current_user.services.page(params[:page])
    end
    authorize @services
  end

  def show
  end

  def new
    if current_user.admin?
      @service = Service.new
    else
      @service = current_user.services.new
    end
    authorize @service
  end

  def edit
  end

  def create
    if current_user.admin?
      @service = Service.new(service_params)
    else
      @service = current_user.services.new(service_params)
    end
    authorize @service

    if @service.save
      redirect_to admin_service_path(@service), notice: 'Услуга создана'
    else
      render action: 'new'
    end
  end

  def update
    if @service.update(service_params)
      redirect_to admin_service_path(@service), notice: 'Услуга обновлена'
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
      authorize @service
    end

    def service_params
      params.require(:service).permit(
        :title,
        :intro,
        :body,
        :cover,
        :remove_cover,
        :service_category_id,
        :user_id,
        :price,
        images_attributes: [
          :id,
          :title,
          :file,
          :_destroy
        ]
      )
    end
end
